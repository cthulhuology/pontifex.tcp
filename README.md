pontifex.tcp
============

A TCP to AMQP Bridge

Getting Started
---------------

To install the pontifex.tcp
	
	npm install pontifex.tcp

And then you can run a bridge
	
	pontifex 'tcp://0.0.0.0:9999//tcp-out/#/tcp/tcp-out/tcp' 'amqp://guest:guest@localhost:5672'

You can then test your echo server

	nc localhost 9999

Note currently there is no framing, so the TCP sockets flush whenever they flush.


