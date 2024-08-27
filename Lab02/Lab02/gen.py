import os

dir = os.path.dirname(__file__)
ip = input(
    "Enter the file name where the code is written, with file extension (like main.asm/main.c): "
)
op = input("Enter the output text file name, without file extension: ")

with open(f"{dir}/{ip}", "r") as f:
    u1 = f.readlines()

with open(f"{dir}/{op}.txt", "w") as f:
    for i in range(len(u1)):
        f.write(f"{i+1} {u1[i]}")
