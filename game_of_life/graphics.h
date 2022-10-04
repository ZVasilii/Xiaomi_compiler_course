#pragma once

#include <SFML/Graphics.hpp>

sf::RenderWindow w;
sf::Event event;

void graph_init(size_t horiz, size_t vertic);
bool graph_is_running();
void graph_is_closed();
void graph_put_pixel(int x, int y, bool state);
void graph_flush();
void graph_clear();

void graph_init(size_t horiz, size_t vertic) 
{
    w.create(sf::VideoMode(horiz, vertic), "Game of Death");
}

bool graph_is_running() 
{
    return  w.isOpen();
}

void graph_is_closed() 
{
    while (w.pollEvent(event)) 
    {
        if (event.type == sf::Event::Closed)
            w.close();
    }
}

void graph_put_pixel(int x, int y, bool state) 
{
    sf::Color color = state ? sf::Color::Cyan : sf::Color::Black;
    sf::Vertex vertex({(float) x, (float) y}, color);
    w.draw(&vertex, 1, sf::Points);
}

void graph_flush() 
{
    w.display();
}

void graph_clear() 
{
    w.clear(sf::Color::Black);
}