"""
Hotel distributed data storage system using the Pyro5 remote object paradigm.

The `hotel` class exposes eleven remote methods for managing hotel guests and
rental rooms.  Each method is decorated with ``@Pyro5.api.expose`` so that a
Pyro5 daemon can publish an instance as a named remote object that client code
can call transparently over the network.

Guests
------
* name  – str
* guest_id – int (unique per instance)

Rooms
-----
* room_number    – positive int (unique per instance)
* num_beds       – positive int
* price_per_night – positive int
* is_clean       – bool  (True = clean)
"""

import Pyro5.api


@Pyro5.api.expose
class hotel(object):
    """Remote-object class that stores hotel guest and room information."""

    # ------------------------------------------------------------------
    # Lifecycle
    # ------------------------------------------------------------------

    def __init__(self):
        # {guest_id: {"name": str, "guest_id": int}}
        self._guests = {}
        # {room_number: {"room_number": int, "num_beds": int,
        #                "price_per_night": int, "is_clean": bool}}
        self._rooms = {}

    # ==================================================================
    # Task 1 – Add a guest
    # ==================================================================

    def add_guest(self, name: str, guest_id: int) -> bool:
        """Store a new guest.

        Parameters
        ----------
        name:     Guest name (str).
        guest_id: Unique integer identifier for the guest.

        Returns
        -------
        True if the guest was added; False if guest_id already exists.
        """
        if not isinstance(name, str) or not isinstance(guest_id, int):
            raise TypeError("name must be str and guest_id must be int")
        if guest_id in self._guests:
            return False
        self._guests[guest_id] = {"name": name, "guest_id": guest_id}
        return True

    # ==================================================================
    # Task 2 – Remove a guest
    # ==================================================================

    def remove_guest(self, guest_id: int) -> bool:
        """Remove a guest by their unique identifier.

        Returns True if removed, False if no guest with that id exists.
        """
        if guest_id in self._guests:
            del self._guests[guest_id]
            return True
        return False

    # ==================================================================
    # Task 3 – Get a single guest
    # ==================================================================

    def get_guest(self, guest_id: int) -> dict:
        """Return the dict for one guest, or an empty dict if not found."""
        return dict(self._guests.get(guest_id, {}))

    # ==================================================================
    # Task 4 – List all guests
    # ==================================================================

    def get_all_guests(self) -> list:
        """Return a list of dicts, one per stored guest."""
        return [dict(g) for g in self._guests.values()]

    # ==================================================================
    # Task 5 – Add a room
    # ==================================================================

    def add_room(
        self,
        room_number: int,
        num_beds: int,
        price_per_night: int,
        is_clean: bool,
    ) -> bool:
        """Store a new rental room.

        Parameters
        ----------
        room_number:     Positive integer room identifier (must be unique).
        num_beds:        Number of beds (positive integer).
        price_per_night: Nightly price in whole currency units (positive int).
        is_clean:        True if the room is currently clean.

        Returns
        -------
        True if added; False if room_number already exists or inputs invalid.
        """
        if (
            not isinstance(room_number, int)
            or not isinstance(num_beds, int)
            or not isinstance(price_per_night, int)
            or not isinstance(is_clean, bool)
        ):
            raise TypeError("room_number/num_beds/price_per_night must be int; is_clean must be bool")
        if room_number <= 0 or num_beds <= 0 or price_per_night <= 0:
            raise ValueError("room_number, num_beds, and price_per_night must be positive")
        if room_number in self._rooms:
            return False
        self._rooms[room_number] = {
            "room_number": room_number,
            "num_beds": num_beds,
            "price_per_night": price_per_night,
            "is_clean": is_clean,
        }
        return True

    # ==================================================================
    # Task 6 – Remove a room
    # ==================================================================

    def remove_room(self, room_number: int) -> bool:
        """Remove a room by its room number.

        Returns True if removed, False if not found.
        """
        if room_number in self._rooms:
            del self._rooms[room_number]
            return True
        return False

    # ==================================================================
    # Task 7 – Get a single room
    # ==================================================================

    def get_room(self, room_number: int) -> dict:
        """Return the dict for one room, or an empty dict if not found."""
        return dict(self._rooms.get(room_number, {}))

    # ==================================================================
    # Task 8 – List all rooms
    # ==================================================================

    def get_all_rooms(self) -> list:
        """Return a list of dicts, one per stored room."""
        return [dict(r) for r in self._rooms.values()]

    # ==================================================================
    # Task 9 – Update room cleanliness
    # ==================================================================

    def update_room_cleanliness(self, room_number: int, is_clean: bool) -> bool:
        """Set the cleanliness indicator for a specific room.

        Returns True if updated, False if room_number not found.
        """
        if room_number not in self._rooms:
            return False
        self._rooms[room_number]["is_clean"] = is_clean
        return True

    # ==================================================================
    # Task 10 – Find rooms by number of beds
    # ==================================================================

    def get_rooms_by_beds(self, num_beds: int) -> list:
        """Return all rooms that have exactly ``num_beds`` beds."""
        return [dict(r) for r in self._rooms.values() if r["num_beds"] == num_beds]

    # ==================================================================
    # Task 11 – Find rooms within a maximum nightly price
    # ==================================================================

    def get_rooms_by_max_price(self, max_price: int) -> list:
        """Return all rooms whose nightly price is <= ``max_price``."""
        return [dict(r) for r in self._rooms.values() if r["price_per_night"] <= max_price]
