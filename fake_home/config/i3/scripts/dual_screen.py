import os
import sys
import argparse
import logging
logger = logging.getLogger("dual_screen")

LAPTOP_SCREEN = "eDP-1-0"
EXTRA_SCREEN = "HDMI-A-1-0"

SCRIPT_FOLDER = os.path.dirname(__file__)
DATA_FOLDER = os.path.join(SCRIPT_FOLDER, "tmp")
DATA_FILE = os.path.join(DATA_FOLDER, "dual_screen.dat")

STATES = [
    [
        f"xrandr --output {EXTRA_SCREEN} --right-of {LAPTOP_SCREEN}",
    ],
    [
        f"xrandr --output {LAPTOP_SCREEN} --off",
    ],
    [
        f"xrandr --output {LAPTOP_SCREEN} --auto --same-as {EXTRA_SCREEN}",
    ],
]





def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--use_current", action="store_true", default=False)
    return parser.parse_args()

def main():
    os.makedirs(DATA_FOLDER, exist_ok=True)
    
    args = parse_args()

    state = 0
    if os.path.exists(DATA_FILE):
        with open(DATA_FILE) as fin:
            try:
                state = int(fin.readline().strip())
            except Exception as e:
                logger.error(e, exc_info=True)
                state = 1
    if not args.use_current:
        state += 1
    state %= len(STATES)

    # Update state file
    with open(DATA_FILE, "w") as fout:
        fout.write(str(state))

    state_cmd = STATES[state]
    for cmd in state_cmd:
        os.system(cmd)

if __name__ == "__main__":
    main()
