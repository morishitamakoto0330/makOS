/* bootpackのメイン */

#include "bootpack.h"
#include <stdio.h>
#include <string.h>

void console_task(struct SHEET *sheet, unsigned int memtotal, unsigned int cons_x, unsigned int cons_y)
{
	struct TIMER *timer;
	struct TASK *task = task_now();
	int i, fifobuf[128], cursor_x = 16, cursor_y = 28, cursor_c = -1;
	int row = cons_y / 16, row_count, newline_flag;
	char s[30], cmdline[30], *p;
	struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
	int x, y;
	struct FILEINFO *finfo = (struct FILEINFO *) (ADR_DISKIMG + 0x002600);
	int *fat = (int *) memman_alloc_4k(memman, 4 * 2880);

	fifo32_init(&task->fifo, 128, fifobuf, task);
	timer = timer_alloc();
	timer_init(timer, &task->fifo, 1);
	timer_settime(timer, 50);
	file_readfat(fat, (unsigned char *) (ADR_DISKIMG + 0x000200));

	/* プロンプト表示 */
	putfonts8_asc_sht(sheet, 8, 28, COL8_FFFFFF, COL8_000000, ">", 1);

	for (;;) {
		io_cli();
		if (fifo32_status(&task->fifo) == 0) {
			task_sleep(task);
			io_sti();
		} else {
			i = fifo32_get(&task->fifo);
			io_sti();
			if (i <= 1) { /* カーソル用タイマ */
				if (i != 0) {
					timer_init(timer, &task->fifo, 0); /* 次は0を */
					if(cursor_c >= 0) {
						cursor_c = COL8_FFFFFF;
					}
				} else {
					timer_init(timer, &task->fifo, 1); /* 次は1を */
					if(cursor_c >= 0) {
						cursor_c = COL8_000000;
					}
				}
				timer_settime(timer, 50);
			}
			if (i == 2) {	/* カーソルON */
				cursor_c = COL8_FFFFFF;
			}
			if (i == 3) {	/* カーソルOFF */
				boxfill8(sheet->buf, sheet->bxsize, COL8_000000, cursor_x, cursor_y, cursor_x + 7, 43);
				cursor_c = -1;
			}
			if (256 <= i && i <= 511) { /* キーボードデータ（タスクA経由） */
				if (i == 8 + 256) {
					/* バックスペース */
					if (cursor_x > 16) {
						/* カーソルをスペースで消してから、カーソルを1つ戻す */
						putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, " ", 1);
						cursor_x -= 8;
					}
				} else if(i == 10 + 256) {
					/* Enter */
					/* カーソルをスペースで消してから改行する */
					putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, " ", 1);
					cmdline[cursor_x / 8 - 2] = 0;
					cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
					/* コマンド実行 */
					if(strcmp(cmdline, "mem") == 0) {
						/* memコマンド */
						sprintf(s, "total   %dMB", memtotal / (1024 * 1024));
						putfonts8_asc_sht(sheet, 8, cursor_y, COL8_FFFFFF, COL8_000000, s, 30);
						cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
						sprintf(s, "free %dKB", memman_total(memman) / 1024);
						putfonts8_asc_sht(sheet, 8, cursor_y, COL8_FFFFFF, COL8_000000, s, 30);
						cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
						cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
					} else if(strcmp(cmdline, "cls") == 0) {
						/* clsコマンド */
						for (y = 28; y < cons_y + 28; y++) {
							for (x = 8; x < cons_x + 8; x++) {
								sheet->buf[x + y * sheet->bxsize] = COL8_000000;
							}
						}
						sheet_refresh(sheet, 8, 28, cons_x + 8, cons_y + 28);
						cursor_y = 28;
					} else if (strcmp(cmdline, "ls") == 0) {
						/* lsコマンド */
						for (x = 0; x < 224; x++) {
							if (finfo[x].name[0] == 0x00) {
								break;
							}
							if (finfo[x].name[0] != 0xe5) {
								if ((finfo[x].type & 0x18) == 0) {
									sprintf(s, "filename.ext   %7d", finfo[x].size);
									for (y = 0; y < 8; y++) {
										s[y] = finfo[x].name[y];
									}
									if(finfo[x].ext[0] == 0x20) { 
										s[8] = 0x20;
									}
									s[ 9] = finfo[x].ext[0];
									s[10] = finfo[x].ext[1];
									s[11] = finfo[x].ext[2];
									putfonts8_asc_sht(sheet, 8, cursor_y, COL8_FFFFFF, COL8_000000, s, 30);
									cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
								}
							}
						}
						cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
					} else if (strncmp(cmdline, "cat ", 4) == 0) {
						/* catコマンド */
						/* ファイル名を準備する */
						for (y = 0; y < 11; y++) {
							s[y] = ' ';
						}
						y = 0;
						for (x = 4; y < 11 && cmdline[x] != 0; x++) {
							if (cmdline[x] == '.' && y <= 8) {
								y = 8;
							} else {
								s[y] = cmdline[x];
								if ('a' <= s[y] && s[y] <= 'z') {
									/* 小文字は大文字に直す */
									s[y] -= 0x20;
								} 
								y++;
							}
						}
						/* ファイルを探す */
						for (x = 0; x < 224; ) {
							if (finfo[x].name[0] == 0x00) {
								break;
							}
							if ((finfo[x].type & 0x18) == 0) {
								for (y = 0; y < 11; y++) {
									if (finfo[x].name[y] != s[y]) {
										goto type_next_file;
									}
								}
								break; /* ファイルが見つかった */
							}
			type_next_file:
							x++;
						}
						if (x < 224 && finfo[x].name[0] != 0x00) {
							/* ファイルが見つかった場合 */
							p = (char *) memman_alloc_4k(memman, finfo[x].size);
							file_loadfile(finfo[x].clustno, finfo[x].size, p, fat, (char *) (ADR_DISKIMG + 0x003e00));
							cursor_x = 8;
							for (y = 0; y < finfo[x].size; y++) {
								/* 1文字ずつ出力 */
								s[0] = p[y];
								s[1] = 0;
								if (s[0] == 0x09) {	/* タブ */
									for (;;) {
										putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, " ", 1);
										cursor_x += 8;
										if (cursor_x == 8 + cons_x) {
											cursor_x = 8;
											cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
										}
										if (((cursor_x - 8) & 0x1f) == 0) {
											break;	/* 32で割り切れたらbreak */
										}
									}
								} else if (s[0] == 0x0a) {	/* 改行 */
									cursor_x = 8;
									cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
								} else if (s[0] == 0x0d) {	/* 復帰 */
									/* とりあえずなにもしない */
								} else { /* 普通の文字 */
									putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, s, 1);
									cursor_x += 8;
									if (cursor_x == 8 + cons_x) {
										cursor_x = 8;
										cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
									}
								}
							}
							memman_free_4k(memman, (int) p, finfo[x].size);
						} else {
							/* ファイルが見つからなかった場合 */
							putfonts8_asc_sht(sheet, 8, cursor_y, COL8_FFFFFF, COL8_000000, "File not found.", 15);
							cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
						}
					} else if (strncmp(cmdline, "more ", 5) == 0) {
						/* moreコマンド */
						/* ファイル名を準備する */
						for (y = 0; y < 11; y++) {
							s[y] = ' ';
						}
						y = 0;
						for (x = 5; y < 11 && cmdline[x] != 0; x++) {
							if (cmdline[x] == '.' && y <= 8) {
								y = 8;
							} else {
								s[y] = cmdline[x];
								if ('a' <= s[y] && s[y] <= 'z') {
									/* 小文字は大文字に直す */
									s[y] -= 0x20;
								} 
								y++;
							}
						}
						/* ファイルを探す */
						for (x = 0; x < 224; ) {
							if (finfo[x].name[0] == 0x00) {
								break;
							}
							if ((finfo[x].type & 0x18) == 0) {
								for (y = 0; y < 11; y++) {
									if (finfo[x].name[y] != s[y]) {
										goto type_next_file2;
									}
								}
								break; /* ファイルが見つかった */
							}
			type_next_file2:
							x++;
						}
						if (x < 224 && finfo[x].name[0] != 0x00) {
							/* ファイルが見つかった場合 */
							p = (char *) memman_alloc_4k(memman, finfo[x].size);
							file_loadfile(finfo[x].clustno, finfo[x].size, p, fat, (char *) (ADR_DISKIMG + 0x003e00));
							row_count = 0;
							cursor_x = 8;
							for (y = 0; y < finfo[x].size; y++) {
								newline_flag = 0;
								/* 1文字ずつ出力 */
								s[0] = p[y];
								s[1] = 0;
								if (s[0] == 0x09) {	/* タブ */
									for (;;) {
										putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, " ", 1);
										cursor_x += 8;
										if (cursor_x == 8 + cons_x) {
											cursor_x = 8;
											cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
											row_count++;
											newline_flag = 1;
										}
										if (((cursor_x - 8) & 0x1f) == 0) {
											break;	/* 32で割り切れたらbreak */
										}
									}
								} else if (s[0] == 0x0a) {	/* 改行 */
									if(cursor_x == 8) { /* いきなり改行コードが来たら */
										putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, " ", 1);
									}
									cursor_x = 8;
									cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
									row_count++;
									newline_flag = 1;
								} else if (s[0] == 0x0d) {	/* 復帰 */
									/* とりあえずなにもしない */
								} else { /* 普通の文字 */
									putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, s, 1);
									cursor_x += 8;
									if (cursor_x == 8 + cons_x) {
										cursor_x = 8;
										cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
										row_count++;
										newline_flag = 1;
									}
								}
								if((row_count >= row - 1) && (newline_flag == 1)) {
									/* moreのアレ表示 */
									putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, ":", 1);
									while(fifo32_get(&task->fifo) != 10 + 256) { /* Enterが押されるまでHLT */
										io_hlt();
									}
								}
							}
							memman_free_4k(memman, (int) p, finfo[x].size);
						} else {
							/* ファイルが見つからなかった場合 */
							putfonts8_asc_sht(sheet, 8, cursor_y, COL8_FFFFFF, COL8_000000, "File not found.", 15);
							cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
						}
					} else if(cmdline[0] != 0) {
						/* コマンドではなく、さらに空行でもない */
						putfonts8_asc_sht(sheet, 8, cursor_y, COL8_FFFFFF, COL8_000000, "Bad command.", 12);
						cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
						cursor_y = cons_newline(cursor_y, sheet, cons_x, cons_y);
					}
					/* プロンプト表示 */
					putfonts8_asc_sht(sheet, 8, cursor_y, COL8_FFFFFF, COL8_000000, ">", 1);
					cursor_x = 16;
				} else {
					/* 一般文字 */
					if (cursor_x < cons_x) {
						/* 一文字表示してから、カーソルを1つ進める */
						s[0] = i - 256;
						s[1] = 0;
						cmdline[cursor_x / 8 - 2] = i - 256;
						putfonts8_asc_sht(sheet, cursor_x, cursor_y, COL8_FFFFFF, COL8_000000, s, 1);
						cursor_x += 8;
					}
				}
			}
			/* カーソル再表示 */
			if(cursor_c >= 0) {
				boxfill8(sheet->buf, sheet->bxsize, cursor_c, cursor_x, cursor_y, cursor_x + 7, cursor_y + 15);
			}
			sheet_refresh(sheet, cursor_x, cursor_y, cursor_x + 8, cursor_y + 16);
		}
	}
}

int cons_newline(int cursor_y, struct SHEET *sheet, unsigned int cons_x, unsigned int cons_y)
{
	int x, y;
	if (cursor_y < cons_y + 12) {
		cursor_y += 16; /* 次の行へ */
	} else {
		/* スクロール */
		for (y = 28; y < cons_y + 12; y++) {
			for (x = 8; x < cons_x + 8; x++) {
				sheet->buf[x + y * sheet->bxsize] = sheet->buf[x + (y + 16) * sheet->bxsize];
			}
		}
		for (y = cons_y + 12; y < cons_y + 28; y++) {
			for (x = 8; x < cons_x + 8; x++) {
				sheet->buf[x + y * sheet->bxsize] = COL8_000000;
			}
		}
		sheet_refresh(sheet, 8, 28, cons_x + 8, cons_y + 28);
	}
	return cursor_y;
}


