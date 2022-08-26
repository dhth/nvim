import json
import sys

s = sys.stdin

lines = []
for line in sys.stdin:
    lines.append(line.strip())

assert len(lines) == 1, "Multiple lines detected"
s = lines[0]

error_message = "".join(s.split(" (")[:-1])
file_name_with_lnum = s.split(" (")[-1].split(")")[0]
file_name = file_name_with_lnum.split(".scala:")[0]
lnum = file_name_with_lnum.split(".scala:")[-1]

data = dict(
    error_message=error_message,
    file_name_with_lnum=file_name_with_lnum,
    file_name=file_name,
    lnum=lnum,
)
print(json.dumps(data))
