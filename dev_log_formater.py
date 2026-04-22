from datetime import datetime
import subprocess
day = datetime.now().strftime("%Y-%m-%d")

content = f"""
# Dev Log ({day})

## Plan for the day

## Changes

## Issues

## Game state

## Next Steps

---

"""

with open("dev_log.md", "a", encoding="utf-8") as f:
    f.write(content)

print("entry added")

subprocess.run(["explorer.exe", "dev_log.md"])
print("file opened")