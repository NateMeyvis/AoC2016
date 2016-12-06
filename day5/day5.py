import hashlib
import sys

if __name__ == "__main__":
	n = 1
	key = sys.argv[1]
	m = hashlib.md5()
	m.update(key + str(n))
	digest = m.hexdigest()
	for i in range(8):
		while digest[:5] != "00000":
			n += 1
			del m
			m = hashlib.md5()
			m.update(key + str(n))
			digest = m.hexdigest()
		print digest[5], n
		n += 1
		del m
		m = hashlib.md5()
		m.update(key + str(n))
		digest = m.hexdigest()