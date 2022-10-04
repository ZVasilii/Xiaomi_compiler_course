#include <assert.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

#include "graphics.h"

enum size 
{
    HORIZONTAL_SIZE = 1024,
    VERTICAL_SIZE= 980
};

enum state
{
    DEAD = 0,
    ALIVE = 1
};

struct polygon
{
    bool* buff;
    size_t horiz_size;
    size_t vertic_size;
};

struct polygon init_poly(unsigned horiz_size, unsigned vertic_size);
void delete_poly(struct polygon poly);
bool get_state(struct polygon poly, int x, int y);
void set_state(struct polygon poly, int x, int y, bool state);
void create_chaos(struct polygon poly);
size_t count_neighb(struct polygon poly, int x, int y, bool state);
bool determine_state(struct polygon poly, int x, int y);
void evolution(struct polygon game_poly, struct polygon tmp_poly);
void swap_poly(struct polygon* lhs, struct polygon* rhs);
void draw(struct polygon poly);
void finalizing(struct polygon game_poly, struct polygon tmp_poly);

int main() {

    struct polygon game_poly = init_poly(HORIZONTAL_SIZE, VERTICAL_SIZE);
    struct polygon tmp_poly = init_poly(HORIZONTAL_SIZE, VERTICAL_SIZE);

    graph_init(HORIZONTAL_SIZE, VERTICAL_SIZE);
    create_chaos(game_poly);

    while(graph_is_running()) 
    {
        graph_is_closed();
        graph_clear();

        evolution(game_poly, tmp_poly);
        swap_poly(&game_poly, &tmp_poly);
        draw(game_poly);
    }
    finalizing(game_poly, tmp_poly);
}

struct polygon init_poly(unsigned horiz_size, unsigned vertic_size) 
{
    bool* buff = (bool*)calloc(horiz_size * vertic_size, sizeof(bool));
    assert(buff);
    struct polygon tmp = {buff, horiz_size, vertic_size};
    return tmp;
}

bool get_state(struct polygon poly, int x, int y) 
{
    return poly.buff[y + x * poly.vertic_size];
}

void set_state(struct polygon poly, int x, int y, bool state) 
{
    poly.buff[y + x * poly.vertic_size] = state;
}

void delete_poly(struct polygon poly)
{
    free(poly.buff);
}

void create_chaos(struct polygon poly) 
{
    srand(time(NULL));
    for(size_t x = 0; x < poly.horiz_size; ++x)
        for(size_t y = 0; y < poly.vertic_size; ++y)
            set_state(poly, x, y, rand() % 2);
}

size_t count_neighb(struct polygon poly, int x, int y, bool state) 
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

            if (current_x < 0 || (size_t) current_x >= poly.horiz_size ||
                current_y < 0 || (size_t) current_y >= poly.vertic_size) 
            {
                continue;
            }

            if (state == get_state(poly, current_x, current_y)) 
            {
                ++neighb;
            }
        }
    }
    return neighb;
}

bool determine_state(struct polygon poly, int x, int y) 
{
    size_t neighb = count_neighb(poly, x, y, ALIVE);
    if (get_state(poly, x, y) == DEAD)
    {
        if (neighb == 3) 
            return ALIVE; 
    }
    if(get_state(poly, x, y) == ALIVE)
    {
        if ((neighb > 3) || (neighb < 2))
            return DEAD;
        else
            return ALIVE;
    }
    return get_state(poly, x, y);
}

void evolution(struct polygon game_poly, struct polygon tmp_poly) 
{
    for(size_t x = 0; x < game_poly.horiz_size; ++x) 
    {
        for(size_t y = 0; y < game_poly.vertic_size; ++y) 
        {
            bool state = determine_state(game_poly, x, y);
            set_state(tmp_poly, x, y, state);
        }
    }
}

void swap_poly(struct polygon* lhs, struct polygon* rhs) 
{
    struct polygon tmp = *lhs;
    *lhs = *rhs;
    *rhs = tmp;
}

void draw(struct polygon poly) 
{
    for(size_t x = 0; x < poly.horiz_size; ++x)
        for(size_t y = 0; y < poly.vertic_size; ++y)
            graph_put_pixel(x, y, get_state(poly, x, y));
    graph_flush();
}

void finalizing(struct polygon game_poly, struct polygon tmp_poly)
{
    delete_poly(game_poly);
    delete_poly(tmp_poly);
}
