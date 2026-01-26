def move_zero(n):
    left = 0
    for right in range(len(n)):
        if n[right] != 0:
            n[left], n[right] = n[right], n[left]
            left += 1
    return n


def missing(n):
    l = len(n)
    S = (l*(l+1))//2
    s = sum(n)
    return f"Missing: {S-s}"


print(f"Move Zeroes: {move_zero([0,1,0,3,12])}")
print(missing([3,0,1]))