# SecretShare.swift
A pure Swift implementation of <a href="https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing">Shamir's Secret Sharing</a> scheme.

A threshold secret sharing scheme to split data into N secret shares such that
at least K secret shares must be combined to reconstruct the data.

This is scheme is information-theortic secure; An adversary with K-1
or fewer secret shares would produce any data with equal probability,
meaning fewer than K-1 shares reveal nothing about the secret data.

### built at krypt.co

<a href="https://krypt.co"><img src="https://krypt.co/static/dist/img/krypton_core_logo.svg" width="200"/> </a>

__Krypton__ generates and stores an SSH + PGP key pair on a mobile phone. The
Krypton app is paired with one or more workstations by scanning a QR code
presented in the terminal. When using SSH from a paired workstation, the
workstation requests a private key signature from the phone. The user then
receives a notification and chooses whether to allow the SSH login.

For more information, check out [krypt.co](https://krypt.co).

