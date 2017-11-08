from subprocess import call
for i in range(32,33):
    url=f'https://www.bilibili.com/video/av7886139/index_{i}.html'
    print(url)
    call(f'you-get {url}',shell=True,cwd='D:\\')
    