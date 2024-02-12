#! /usr/bin/env python3

import sys
from serial import Serial

serial = Serial(sys.argv[1], timeout=1)
serial.write(b'\xfa\xf3\x00\xf3')
serial.close()

