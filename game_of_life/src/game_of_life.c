#include "graphics.h"

/*
#define DEAD 0
#define ALIVE 1
#define Width 800
#define Height 600
*/

bool game_poly[800 * 600];
bool tmp_poly[800 * 600];

bool get_state(int x, int y);
void set_state(int x, int y, bool state);
void create_chaos();
size_t count_neighb(int x, int y, bool state);
bool determine_state(int x, int y);
void evolution();
void swap_poly();
void draw();

int main() {

    graph_init(800, 600);
    create_chaos();

    while(1)
    {
        graph_is_closed();
        graph_clear();

        evolution();
        swap_poly();
        draw();
    }
}


void create_chaos()
{
    for(size_t x = 0; x < 800; ++x)
        for(size_t y = 0; y < 600; ++y)
            game_poly [x + y * 800] =  graph_rand() % 2;
}

size_t count_neighb(int x, int y, bool state)
{
    size_t neighb = 0;
    for(int current_x = x - 1; current_x <= x + 1; ++current_x)
    {
        for(int current_y = y - 1; current_y <= y + 1; ++current_y)
        {
            if((current_x == x) && (current_y == y))
            {
                continue;
            }

            if (current_x < 0 || (size_t) current_x >= 800 ||
                current_y < 0 || (size_t) current_y >= 600)
            {
                continue;
            }

            if (state == game_poly[current_x + 800 * current_y])
            {
                ++neighb;
            }
        }
    }
    return neighb;
}

bool determine_state( int x, int y)
{
    size_t neighb = count_neighb(x, y, 1);
    if (game_poly[x + y * 800] == 0)
    {
        if (neighb == 3)
            return 1;
    }
    if(game_poly[x + y * 800] == 1)
    {
        if ((neighb > 3) || (neighb < 2))
            return 0;
        else
            return 1;
    }
    return game_poly[x + y * 800];
}

void evolution()
{
    for(size_t x = 0; x < 800; ++x)
    {
        for(size_t y = 0; y < 600; ++y)
        {
            bool state = determine_state(x, y);
            tmp_poly[x + y * 800] = state;
        }
    }
}

void swap_poly()
{
    for(size_t x = 0; x < 800; ++x)
    {
        for(size_t y = 0; y < 600; ++y)
        {
            bool tmp = game_poly[x + y * 800];
            game_poly[x + y * 800] = tmp_poly[x + y * 800];
            tmp_poly[x + y * 800] = tmp;
        }
    }
}

void draw()
{
    for(size_t x = 0; x < 800; ++x)
        for(size_t y = 0; y < 600; ++y)
            graph_put_pixel(x, y, game_poly[x + y * 800]);
    graph_flush();
}
