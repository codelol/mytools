#This is currently quite specific for IOMeter generated csv, not very general-purse.
def parseFile(filepath, interestingFields):
    fd = open(filepath)
    getNameNow = False
    for line in fd:
        if getNameNow:
            getNameNow = False
            accessSpec = line.split(',')[0]
        if line.startswith('\'Target Type'):
            fieldNameArray = line.split(',')
        elif line.startswith('ALL'):
            valuesAll = line.split(',')
        elif line.startswith('\'Access specification name'):
            getNameNow = True
    fd.close()

    fieldValues = {}
    #fieldValues['Acess Spec'] = accessSpec
    for field in interestingFields:
        pos = fieldNameArray.index(field)
        fieldValues[field] = valuesAll[pos]
    return fieldValues

def parseFolder(folderPath, interestingFields):
    import os
    valueAllFiles={}
    for fname in os.listdir(folderPath):
        if fname.endswith('csv') != True:
            continue
        fpath = os.path.join(folderPath, fname)
        values = parseFile(fpath, interestingFields)
        valueAllFiles[fname] = values
    return valueAllFiles


def cmpGenerator(delimiter1, delimiter2):
    def mycmp(x, y):
        hx = x.split(delimiter1)[0]
        hy = y.split(delimiter1)[0]
        if (hx != hy):
            return int(hx) - int(hy)
        else:
            hx = x.split(delimiter1)[1].split(delimiter2)[0]
            hy = y.split(delimiter1)[1].split(delimiter2)[0]
            return int(hx) - int(hy)
    return mycmp

if __name__ == '__main__':
    valueAll = parseFolder('C:\\aaa\\ftp\\4VCPU', [
        'IOps',
        'Average Response Time'
    ])

    keys = list(valueAll.keys())
    keys.sort(cmp = cmpGenerator('W', 'OIO'))
    for key in keys:
        print('%20s: %s' % (key, valueAll[key]))