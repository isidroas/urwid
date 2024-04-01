#!/usr/bin/env python

import os
import socket

import real_browse

os.chdir(os.path.dirname(socket.__file__))
real_browse.main()
