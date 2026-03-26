"""
Hotel Pyro5 server – registers a `hotel` instance as a named remote object.

Usage
-----
  python hotel_server.py

The server registers the object under the name "hotel.storage" with the
Pyro5 name server.  Start the name server first::

    python -m Pyro5.nameserver &

Then start this server in a separate terminal before running hotel_client.py.
"""

import Pyro5.api
from hotel import hotel


def main():
    with Pyro5.api.Daemon() as daemon:
        # Locate the running Pyro5 name server
        ns = Pyro5.api.locate_ns()

        # Register a hotel instance with the daemon and the name server
        uri = daemon.register(hotel())
        ns.register("hotel.storage", uri)

        print(f"hotel.storage registered at {uri}")
        print("Server is running. Press Ctrl-C to stop.")
        daemon.requestLoop()


if __name__ == "__main__":
    main()
