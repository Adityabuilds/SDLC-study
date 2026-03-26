"""
Hotel Pyro5 client – demonstrates all eleven remote operations against a
running hotel_server.py instance.

Usage
-----
  python hotel_client.py

Prerequisites
-------------
1. Start the Pyro5 name server:  python -m Pyro5.nameserver &
2. Start the hotel server:       python hotel_server.py &
3. Run this client:              python hotel_client.py
"""

import Pyro5.api


def print_section(title: str):
    print(f"\n{'='*60}")
    print(f"  {title}")
    print(f"{'='*60}")


def main():
    # Connect to the remote hotel object via the Pyro5 name server
    hotel = Pyro5.api.Proxy("PYRONAME:hotel.storage")

    # ------------------------------------------------------------------
    # Task 1 – Add guests
    # ------------------------------------------------------------------
    print_section("Task 1 – add_guest")
    print(hotel.add_guest("Alice Smith", 101))   # True
    print(hotel.add_guest("Bob Jones", 102))     # True
    print(hotel.add_guest("Carol White", 103))   # True
    print(hotel.add_guest("Alice Smith", 101))   # False (duplicate id)

    # ------------------------------------------------------------------
    # Task 2 – Remove a guest
    # ------------------------------------------------------------------
    print_section("Task 2 – remove_guest")
    print(hotel.remove_guest(103))   # True
    print(hotel.remove_guest(999))   # False (not found)

    # ------------------------------------------------------------------
    # Task 3 – Get a single guest
    # ------------------------------------------------------------------
    print_section("Task 3 – get_guest")
    print(hotel.get_guest(101))   # {'name': 'Alice Smith', 'guest_id': 101}
    print(hotel.get_guest(999))   # {} (not found)

    # ------------------------------------------------------------------
    # Task 4 – List all guests
    # ------------------------------------------------------------------
    print_section("Task 4 – get_all_guests")
    print(hotel.get_all_guests())

    # ------------------------------------------------------------------
    # Task 5 – Add rooms
    # ------------------------------------------------------------------
    print_section("Task 5 – add_room")
    print(hotel.add_room(1, 2, 150, True))    # True
    print(hotel.add_room(2, 1, 90, False))    # True
    print(hotel.add_room(3, 3, 220, True))    # True
    print(hotel.add_room(4, 2, 130, True))    # True
    print(hotel.add_room(1, 2, 150, True))    # False (duplicate room_number)

    # ------------------------------------------------------------------
    # Task 6 – Remove a room
    # ------------------------------------------------------------------
    print_section("Task 6 – remove_room")
    print(hotel.remove_room(4))   # True
    print(hotel.remove_room(99))  # False (not found)

    # ------------------------------------------------------------------
    # Task 7 – Get a single room
    # ------------------------------------------------------------------
    print_section("Task 7 – get_room")
    print(hotel.get_room(1))    # full room dict
    print(hotel.get_room(99))   # {}

    # ------------------------------------------------------------------
    # Task 8 – List all rooms
    # ------------------------------------------------------------------
    print_section("Task 8 – get_all_rooms")
    print(hotel.get_all_rooms())

    # ------------------------------------------------------------------
    # Task 9 – Update room cleanliness
    # ------------------------------------------------------------------
    print_section("Task 9 – update_room_cleanliness")
    print(hotel.update_room_cleanliness(2, True))    # True  (marked clean)
    print(hotel.update_room_cleanliness(99, True))   # False (not found)
    print(hotel.get_room(2))                          # is_clean should be True

    # ------------------------------------------------------------------
    # Task 10 – Find rooms by number of beds
    # ------------------------------------------------------------------
    print_section("Task 10 – get_rooms_by_beds")
    print(hotel.get_rooms_by_beds(2))   # rooms 1 (already removed 4)
    print(hotel.get_rooms_by_beds(1))   # room 2

    # ------------------------------------------------------------------
    # Task 11 – Find rooms within a maximum nightly price
    # ------------------------------------------------------------------
    print_section("Task 11 – get_rooms_by_max_price")
    print(hotel.get_rooms_by_max_price(150))   # rooms 1 and 2
    print(hotel.get_rooms_by_max_price(100))   # room 2 only


if __name__ == "__main__":
    main()
