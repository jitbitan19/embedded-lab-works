with open("output.txt", "w") as file:
    for i in range(31):
        j = 30 - i
        file.write(f"//{j}"+"\n")
        file.write(f"CALL D{j%10}"+"\n")
        file.write(f"OUT PORTC, R16"+"\n")
        j = j // 10
        file.write(f"CALL D{j}"+"\n")
        file.write(f"OUT PORTB, R16"+"\n")
        file.write(f"CALL DELAY1"+"\n")
        file.write(""+"\n")
