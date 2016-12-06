import hashlib
import sys

if __name__ == "__main__":
	answer = ["!"] * 8
	n = 1
	key = sys.argv[1]
	m = hashlib.md5()
	m.update(key + str(n))
	digest = m.hexdigest()
	while "!" in answer:
		while digest[:5] != "00000":
			n += 1
			del m
			m = hashlib.md5()
			m.update(key + str(n))
			digest = m.hexdigest()
		if digest[5] in "01234567" and answer[int(digest[5])] == "!":
			answer[int(digest[5])] = digest[6]
			print ''.join(answer)
		n += 1
		del m
		m = hashlib.md5()
		m.update(key + str(n))
		digest = m.hexdigest()