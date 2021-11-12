# Python code to
# demonstrate readlines()
import time

# writing to file
bufsize = 1
file = open('/Users/palani/ITP/Palani/Jobs/Intuitive/IHSM/IB/observability/testing/input.log', 'w', buffering=bufsize)

# Using readlines()
# file1 = open('/Users/palani/ITP/Palani/Jobs/Intuitive/IHSM/IB/observability/closeoutservice-logs/closeout.log', 'r')
file1 = open('/Users/palani/ITP/Palani/Jobs/Intuitive/IHSM/IB/observability/testing/test.log', 'r')
Lines = file1.readlines()

count = 0
# Strips the newline character
for line in Lines:
    # if line is empty
    # end of file is reached
    if not line:
        break
    count += 1

    # time.sleep(1)
    # l = "Line{}: {}\n".format(count, line.strip())
    l = "{}\n".format(line.strip())
    # l = line.strip()

    file.writelines(l)
    print(l)

file.close()
file1.close()