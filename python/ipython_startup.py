import sys, os, shutil
import datetime
import json
import subprocess as subproc

import numpy as np
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt
import pandas as pd

from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import HasFocus, ViInsertMode
from prompt_toolkit.key_binding.vi_state import InputMode

ipy= get_ipython()
ipy.magic('load_ext autoreload')
ipy.magic('autoreload 1')

q = exit

# nmap C-J <ESC>
def switch_to_navigation_mode(event):
   vi_state = event.cli.vi_state
   vi_state.input_mode = InputMode.NAVIGATION

if getattr(ipy, 'pt_app', None):
   registry = ipy.pt_app.key_bindings
   registry.add_binding(Keys.ControlJ, filter=(HasFocus(DEFAULT_BUFFER)
       & ViInsertMode()))(switch_to_navigation_mode)

if "SUMO_HOME" in os.environ:
    if os.path.join(os.environ["SUMO_HOME"], "tools") not in sys.path:
        sys.path.append(os.path.join(os.environ["SUMO_HOME"], "tools"))

plt.ion()