#        _    _           _                     _                 _
#   __ _| | _| | __    __| | _____      ___ __ | | ___   __ _  __| | ___ _ __ _ __  _   _
#  / _` | |/ / |/ /   / _` |/ _ \ \ /\ / / '_ \| |/ _ \ / _` |/ _` |/ _ \ '__| '_ \| | | |
# | (_| |   <|   <   | (_| | (_) \ V  V /| | | | | (_) | (_| | (_| |  __/ |_ | |_) | |_| |
#  \__, |_|\_\_|\_\___\__,_|\___/ \_/\_/ |_| |_|_|\___/ \__,_|\__,_|\___|_(_)| .__/ \__, |
#  |___/         |_____|                                                     |_|    |___/

# Recibe como parametro de entrada un ticker y hace la busqueda de argv[2] dias (max 60)
# valid intervals: 1m,2m,5m,15m,30m,60m,90m,1h,1d,5d,1wk,1mo,3mo

import yfinance as yf
import sys

output = yf.Ticker(sys.argv[1]).history(period = sys.argv[2])

if len(output) != 0:
    print output
