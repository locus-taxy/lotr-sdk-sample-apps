import Foundation

func + <K, V>(left: [K: V], right: [K: V])
    -> [K: V]
{
    var map = [K: V]()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}
