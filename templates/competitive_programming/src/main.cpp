#include <bits/stdc++.h>

using namespace std;

using ll = long long;
using ull = unsigned long long;
using ld = long double;

using pll = pair<ll, ll>;
using pull = pair<ull, ull>;

using vb = vector<bool>;
using vll = vector<ll>;
using vull = vector<ull>;
using vld = vector<ld>;
using vpll = vector<pll>;
using vpull = vector<pull>;
using vvll = vector<vll>;
using vvull = vector<vull>;

using sll = set<ll>;
using sull = set<ull>;

using mll = map<ll, ll>;
using mull = map<ull, ull>;

#define fastio                                                                                     \
	ios_base::sync_with_stdio(false);                                                              \
	cin.tie(nullptr)
#define mp make_pair
#define fs first
#define sd second
#define all(v) (v).begin(), (v).end()
#define pb push_back
#define rep(i, n) for (ull i = 0; i < (n); i++)
#define tc()                                                                                       \
	ull t;                                                                                         \
	cin >> t;                                                                                      \
	while (t--)

#define bset(x, i) ((x) | (1ULL << (i)))
#define bclr(x, i) ((x) & ~(1ULL << (i)))
#define bchk(x, i) ((x) & (1ULL << (i)))
#define bmsk(n) ((1ULL << (n)) - 1)
#define bcnt(x) (__builtin_popcountll(x))
#define bmsbi(x) (63ULL - __builtin_clzll(x | 1ULL))
#define blsbi(x) (__builtin_ctzll(x | 1ULL))
#define blsb(x) ((x) & -(x))

mull prime_factors(ull n) {
	mull pf;
	for (ull i = 2; i * i <= n; i++) {
		while (n % i == 0) {
			pf[i]++;
			n /= i;
		}
	}
	if (n > 1) {
		pf[n]++;
	}
	return pf;
}
vull divisors(ull n) {
	vull d;
	for (ull i = 1; i * i <= n; i++) {
		if (n % i == 0) {
			d.pb(i);
			if (i * i != n) {
				d.pb(n / i);
			}
		}
	}
	return d;
}
bool is_prime(ull n) {
	if (n < 2) {
		return false;
	}
	if (n == 2 || n == 3) {
		return true;
	}
	if (n % 2 == 0) {
		return false;
	}
	for (ull i = 3; i * i <= n; i += 2) {
		if (n % i == 0) {
			return false;
		}
	}
	return true;
}
vb sieve(ull n) {
	vb b(n + 1, true);
	b[0] = b[1] = false;
	for (ull i = 2; i * i <= n; i++) {
		if (b[i]) {
			for (ull j = i * i; j <= n; j += i) {
				b[j] = false;
			}
		}
	}
	return b;
}
vull primes(ull n) {
	vull p;
	vb b = sieve(n);
	for (ull i = 2; i <= n; i++) {
		if (b[i]) {
			p.pb(i);
		}
	}
	return p;
}
ull modpow(ull b, ull e, ull m) {
	if (m == 1) {
		return 0;
	}
	ull r = 1;
	b %= m;
	while (e > 0) {
		if (e % 2 == 1) {
			r = (r * b) % m;
		}
		b = (b * b) % m;
		e /= 2;
	}
	return r;
}
ull modinv(ull a, ull m) {
	return modpow(a, m - 2, m);
}
ull modstr(const string &s, ull m) {
	ull r = 0;
	for (char c : s) {
		r = (r * 10ULL + (c - '0')) % m;
	}
	return r;
}

int main() {
	fastio;
}
