

tablo = []

for i in range(9):
    # satirlarin dongusu
    tablo.append([])
    for j in range(9):
        # sutun dongusu   
        print(str((i+1)*(j+1)), end="\t")
        tablo[i].append((i+1)*(j+1))
    print("")
        
        

print(tablo)