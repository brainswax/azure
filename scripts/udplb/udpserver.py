#! /usr/bin/env python3
import socketserver
import threading
import socket

# Configuration
PORTS=[9000, 9001, 9002]
HOSTNAME = socket.gethostname()  # Get the hostname once at startup

class UDPHandler(socketserver.BaseRequestHandler):
    def handle(self):
        # Extract data and socket from the request
        data = self.request[0].strip()  # Incoming data from client
        socket = self.request[1]  # Socket to send response
        client_address = self.client_address  # Client's (source) address: (IP, port)
        server_address = self.server.server_address  # Server's (destination) address: (IP, port)

        # Decode received data (assuming it's a string)
        try:
            received_string = data.decode('utf-8')
        except UnicodeDecodeError:
            received_string = "<non-UTF-8 data>"

        # Log details: source IP/port, destination IP/port, and client message
        log_message = (
            f"Received from {client_address[0]}:{client_address[1]} "
            f"to {server_address[0]}:{server_address[1]}: {received_string}"
            f"Message: {received_string}"
        )
        print(log_message)

        try:
            # Create response with source and destination details
            response = (
                f"Source: {client_address[0]}:{client_address[1]}, "
                f"Destination: {server_address[0]}:{server_address[1]}, "
                f"Hostname: {HOSTNAME}, "
                f"Message: {received_string}"
                f"\n"
            )

            # Send response back to client
            socket.sendto(response.encode('utf-8'), client_address)
            print(f"Sent response to {client_address[0]}:{client_address[1]} on port {server_address[1]}")
        except Exception as e:
            error_msg = f"Error: {str(e)}"
            socket.sendto(error_msg.encode('utf-8'), client_address)
            print(f"Sent error to {client_address[0]}:{client_address[1]} on port {server_address[1]}: {error_msg}")

if __name__ == "__main__":
    # List to hold server instances
    servers = []

    # Create a ThreadingUDPServer for each port
    for port in PORTS:
        try:
            server = socketserver.ThreadingUDPServer(('0.0.0.0', port), UDPHandler)
            servers.append(server)
            # Start the server in a separate thread
            print(f"Starting UDP server on port {port}...")
            server_thread = threading.Thread(target=server.serve_forever)
            server_thread.daemon = True  # Allows program to exit cleanly
            server_thread.start()
        except OSError as e:
            print(f"Failed to start server on port {port}: {e}")
            continue

    try:
        # Keep the main thread running
        while True:
            pass
    except KeyboardInterrupt:
        print("\nShutting down all servers...")
        for server in servers:
            server.shutdown()
            server.server_close()
