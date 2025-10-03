//
//  CurrencyModel.swift
//  SpeedyCash
//
//  Created by Bhavananda Das on 12.06.2025.
//

import Foundation

struct CurrencyModel: Identifiable, Equatable, Decodable {
    var id: String { code }
    let flag: String
    let code: String
    let currencyName: String
    let rate: Double

    init(code: String, rate: Double) {
        self.code = code.uppercased()
        self.rate = rate

        let info = CurrencyModel.currencyInfo[code.lowercased()]
        self.flag = info?.flag ?? "🏳️"
        self.currencyName = info?.name ?? code.uppercased()
    }

    struct CurrencyInfo {
        let name: String
        let flag: String
    }

    static let currencyInfo: [String: CurrencyInfo] = [
        "usd": .init(name: "US Dollar", flag: "🇺🇸"),
        "eur": .init(name: "Euro", flag: "🇪🇺"),
        "uah": .init(name: "Ukrainian Hryvnia", flag: "🇺🇦"),
        "jpy": .init(name: "Japanese Yen", flag: "🇯🇵"),
        "gbp": .init(name: "British Pound", flag: "🇬🇧"),
        "pln": .init(name: "Polish Zloty", flag: "🇵🇱"),
        "rub": .init(name: "Russian Ruble", flag: "🇷🇺"),
        "cny": .init(name: "Chinese Yuan", flag: "🇨🇳"),
        "inr": .init(name: "Indian Rupee", flag: "🇮🇳"),
        "brl": .init(name: "Brazilian Real", flag: "🇧🇷"),
        "cad": .init(name: "Canadian Dollar", flag: "🇨🇦"),
        "aud": .init(name: "Australian Dollar", flag: "🇦🇺"),
        "chf": .init(name: "Swiss Franc", flag: "🇨🇭"),
        "sek": .init(name: "Swedish Krona", flag: "🇸🇪"),
        "nok": .init(name: "Norwegian Krone", flag: "🇳🇴"),
        "czk": .init(name: "Czech Koruna", flag: "🇨🇿"),
        "huf": .init(name: "Hungarian Forint", flag: "🇭🇺"),
        "bgn": .init(name: "Bulgarian Lev", flag: "🇧🇬"),
        "try": .init(name: "Turkish Lira", flag: "🇹🇷"),
        "ils": .init(name: "Israeli Shekel", flag: "🇮🇱"),
        "sgd": .init(name: "Singapore Dollar", flag: "🇸🇬"),
        "krw": .init(name: "South Korean Won", flag: "🇰🇷"),
        "mxn": .init(name: "Mexican Peso", flag: "🇲🇽"),
        "zar": .init(name: "South African Rand", flag: "🇿🇦"),
        "dkk": .init(name: "Danish Krone", flag: "🇩🇰"),
        "nzd": .init(name: "New Zealand Dollar", flag: "🇳🇿"),
        "egp": .init(name: "Egyptian Pound", flag: "🇪🇬"),
        "ngn": .init(name: "Nigerian Naira", flag: "🇳🇬"),
        "idr": .init(name: "Indonesian Rupiah", flag: "🇮🇩"),
        "thb": .init(name: "Thai Baht", flag: "🇹🇭"),
        "myr": .init(name: "Malaysian Ringgit", flag: "🇲🇾"),
        "php": .init(name: "Philippine Peso", flag: "🇵🇭"),
        "vnd": .init(name: "Vietnamese Dong", flag: "🇻🇳"),
        "bdt": .init(name: "Bangladeshi Taka", flag: "🇧🇩"),
        "pkr": .init(name: "Pakistani Rupee", flag: "🇵🇰"),
        "pol": .init(name: "Polkadot", flag: "🏳️"),
        "tjs": .init(name: "Tajikistani Somoni", flag: "🇹🇯"),
        "xtz": .init(name: "Tezos", flag: "🏳️"),
        "cvx": .init(name: "Convex Finance", flag: "🏳️"),
        "aave": .init(name: "Aave", flag: "🏳️"),
        "jep": .init(name: "Jersey Pound", flag: "🇯🇪"),
        "tmt": .init(name: "Turkmenistani Manat", flag: "🇹🇲"),
        "rune": .init(name: "THORChain", flag: "🏳️"),
        "mkd": .init(name: "Macedonian Denar", flag: "🇲🇰"),
        "esp": .init(name: "Spanish Peseta", flag: "🇪🇸"),
        "xdc": .init(name: "XDC Network", flag: "🏳️"),
        "xpd": .init(name: "Palladium (ounce)", flag: "🏳️"),
        "val": .init(name: "Vatican Lira", flag: "🇻🇦"),
        "bif": .init(name: "Burundian Franc", flag: "🇧🇮"),
        "cuc": .init(name: "Cuban Convertible Peso", flag: "🇨🇺"),
        "crc": .init(name: "Costa Rican Colón", flag: "🇨🇷"),
        "srd": .init(name: "Surinamese Dollar", flag: "🇸🇷"),
        "xpf": .init(name: "CFP Franc", flag: "🇵🇫"),
        "all": .init(name: "Albanian Lek", flag: "🇦🇱"),
        "ltl": .init(name: "Lithuanian Litas", flag: "🇱🇹"),
        "sle": .init(name: "Sierra Leonean Leone", flag: "🇸🇱"),
        "bch": .init(name: "Bitcoin Cash", flag: "🏳️"),
        "xaf": .init(name: "Central African CFA Franc", flag: "🇨🇫"),
        "uyu": .init(name: "Uruguayan Peso", flag: "🇺🇾"),
        "xag": .init(name: "Silver (ounce)", flag: "🏳️"),
        "afn": .init(name: "Afghan Afghani", flag: "🇦🇫"),
        "srg": .init(name: "Surinamese Guilder", flag: "🇸🇷"),
        "khr": .init(name: "Cambodian Riel", flag: "🇰🇭"),
        "hbar": .init(name: "Hedera", flag: "🏳️"),
        "rol": .init(name: "Old Romanian Leu", flag: "🇷🇴"),
        "mwk": .init(name: "Malawian Kwacha", flag: "🇲🇼"),
        "okb": .init(name: "OKB", flag: "🏳️"),
        "kes": .init(name: "Kenyan Shilling", flag: "🇰🇪"),
        "sui": .init(name: "Sui", flag: "🏳️"),
        "leo": .init(name: "LEO Token", flag: "🏳️"),
        "frax": .init(name: "Frax", flag: "🏳️"),
        "mtl": .init(name: "Maltese Lira", flag: "🇲🇹"),
        "egld": .init(name: "MultiversX", flag: "🏳️"),
        "mzm": .init(name: "Old Mozambican Metical", flag: "🇲🇿"),
        "ron": .init(name: "Romanian Leu", flag: "🇷🇴"),
        "shib": .init(name: "Shiba Inu", flag: "🏳️"),
        "ugx": .init(name: "Ugandan Shilling", flag: "🇺🇬"),
        "lbp": .init(name: "Lebanese Pound", flag: "🇱🇧"),
        "ars": .init(name: "Argentine Peso", flag: "🇦🇷"),
        "axs": .init(name: "Axie Infinity", flag: "🏳️"),
        "mzn": .init(name: "Mozambican Metical", flag: "🇲🇿"),
        "one": .init(name: "Harmony", flag: "🏳️"),
        "mina": .init(name: "Mina Protocol", flag: "🏳️"),
        "ar": .init(name: "Arweave", flag: "🏳️"),
        "ggp": .init(name: "Guernsey Pound", flag: "🇬🇬"),
        "lkr": .init(name: "Sri Lankan Rupee", flag: "🇱🇰"),
        "jmd": .init(name: "Jamaican Dollar", flag: "🇯🇲"),
        "sol": .init(name: "Solana", flag: "🏳️"),
        "sll": .init(name: "Sierra Leonean Leone", flag: "🇸🇱"),
        "celo": .init(name: "Celo", flag: "🏳️"),
        "usdp": .init(name: "Pax Dollar", flag: "🏳️"),
        "cake": .init(name: "PancakeSwap", flag: "🏳️"),
        "wst": .init(name: "Samoan Tala", flag: "🇼🇸"),
        "kda": .init(name: "Kadena", flag: "🏳️"),
        "isk": .init(name: "Icelandic Króna", flag: "🇮🇸"),
        "dfi": .init(name: "DeFiChain", flag: "🏳️"),
        "pte": .init(name: "Portuguese Escudo", flag: "🇵🇹"),
        "agix": .init(name: "SingularityNET", flag: "🏳️"),
        "kyd": .init(name: "Cayman Islands Dollar", flag: "🇰🇾"),
        "theta": .init(name: "Theta", flag: "🏳️"),
        "cro": .init(name: "Cronos", flag: "🏳️"),
        "mkr": .init(name: "Maker", flag: "🏳️"),
        "trl": .init(name: "Turkish Lira (Old)", flag: "🇹🇷"),
        "cup": .init(name: "Cuban Peso", flag: "🇨🇺"),
        "xmr": .init(name: "Monero", flag: "🏳️"),
        "cop": .init(name: "Colombian Peso", flag: "🇨🇴"),
        "gusd": .init(name: "Gemini Dollar", flag: "🏳️"),
        "clp": .init(name: "Chilean Peso", flag: "🇨🇱"),
        "xdr": .init(name: "IMF Special Drawing Rights", flag: "🏳️"),
        "1inch": .init(name: "1inch", flag: "🏳️"),
        "mnt": .init(name: "Mongolian Tögrög", flag: "🇲🇳"),
        "neo": .init(name: "NEO", flag: "🏳️"),
        "zmk": .init(name: "Zambian Kwacha (Old)", flag: "🇿🇲"),
        "kmf": .init(name: "Comorian Franc", flag: "🇰🇲"),
        "ton": .init(name: "Toncoin", flag: "🏳️"),
        "cspr": .init(name: "Casper", flag: "🏳️"),
        "xpt": .init(name: "Platinum (ounce)", flag: "🏳️"),
        "gmx": .init(name: "GMX", flag: "🏳️"),
        "scr": .init(name: "Seychellois Rupee", flag: "🇸🇨"),
        "sos": .init(name: "Somali Shilling", flag: "🇸🇴")
    ]
}

struct CurrencyResponse: Decodable {
    let usd: [String: Double]
}
