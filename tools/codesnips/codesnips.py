import os
import shutil
import sys

def main():
    root_dir = "./"
    snip_dir = "tools/codesnips/snips/"
    if (not os.path.exists(snip_dir)):
        os.makedirs(snip_dir)

    try:
        fp = open("tools/codesnips/codesnips.txt", "r")
    except:
        print("Could not open codesnips.txt")
        return
    
    lines = fp.readlines()
    
    for line in lines:
        line = line.replace("\n", "")
        filename = line.split("/")[-1]
        try:
            shutil.copyfile(root_dir+line, snip_dir+filename)
        except:
            print("Issue copying" + line)
            continue
    
    return    

if __name__ == "__main__":
    main()
    sys.exit()