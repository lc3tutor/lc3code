import os
import shutil
import sys

def main():
    root_dir = "../../"
    snip_dir = "snips/"
    try:
        fp = open("codesnips.txt", "r")
    except:
        return
    
    lines = fp.readlines()
    
    for line in lines:
        line = line.replace("\n", "")
        filename = line.split("/")[-1]
        try:
            shutil.copyfile(root_dir+line, snip_dir+filename)
        except:
            continue

    #root_dir_list = os.listdir(root_dir)
    #user_dir_list = os.listdir(user_dir)
    
    return    

if __name__ == "__main__":
    main()
    sys.exit()