from pathlib import Path

FILE = "content.input"
path = Path(__file__).parent.resolve()/FILE


def read_input() -> str:
    return open(path).read().strip()
