from random import randint
for i in range(100000):
    cur_int = randint(-1000, 1000)
    if cur_int != 0:
        print("num(" + str(i) + "," + str(cur_int) + ").")
