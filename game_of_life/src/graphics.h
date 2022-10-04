#pragma once

void graph_init(size_t horiz, size_t vertic);
bool graph_is_running();
void graph_is_closed();
void graph_put_pixel(int x, int y, bool state);
void graph_flush();
void graph_clear();