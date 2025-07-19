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
using vvull = vector<vull>;
using vld = vector<ld>;
using vpll = vector<pll>;
using vpull = vector<pull>;

#define fastio                                                                                     \
	ios_base::sync_with_stdio(false);                                                              \
	cin.tie(nullptr);
#define inputfile(path) freopen(path, "r", stdin)

#define pb push_back
#define mp make_pair
#define all(v) (v).begin(), (v).end()
#define rep(i, n) for (ull i = 0; i < (n); i++)
#define tc()                                                                                       \
	ull t;                                                                                         \
	cin >> t;                                                                                      \
	while (t--)

#define bset(x, i) ((x) | (1ULL << (i)))
#define bclr(x, i) ((x) & ~(1ULL << (i)))
#define bchk(x, i) ((x) & (1ULL << (i)))
#define bmsk(n) ((1ULL << (n)) - 1ULL)
#define bcnt(x) (__builtin_popcountll(x))
#define bmsbi(x) (63ULL - __builtin_clzll(x | 1ULL))
#define blsbi(x) (__builtin_ctzll(x | 1ULL))
#define blsb(x) ((x) & -(x))

int main() {
	fastio;
}
