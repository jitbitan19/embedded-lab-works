#include <bits/stdc++.h>
using namespace std;
#define ll long long int
#define vll vector<ll>
ll inf = 1e9;

void prefix_arr(ll p[], ll a[], ll n)
{
    p[0] = a[0];
    for (ll i = 1; i < n; i++)
        p[i] = p[i - 1] + a[i];
}

ll __lcm(ll a, ll b)
{
    return a * b / __gcd(a, b);
}

ll max_arr(ll a[], ll n)
{
    ll x = a[0];
    for (ll i = 0; i < n; i++)
        x = max(x, a[i]);
    return x;
}

ll min_arr(ll a[], ll n)
{
    ll x = a[0];
    for (ll i = 0; i < n; i++)
        x = min(x, a[i]);
    return x;
}

void show_arr(ll a[], ll n)
{
    cout << "-->";
    for (ll i = 0; i < n; i++)
        cout << a[i] << " ";
    cout << '\n';
}

void fn()
{
    ll a = 6;
    cout << __builtin_popcountll(a) << '\n';
    cout << __builtin_clzll(a) << '\n';
}

int main()
{
    ios::sync_with_stdio(false), cin.tie(NULL);
    // int t;
    // cin >> t;
    // while (t--)
    fn();
    return 0;
}