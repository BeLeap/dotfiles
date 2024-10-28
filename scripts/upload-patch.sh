#!/bin/bash

git send-email --to='~beleap/dotfiles@lists.sr.ht' --suppress-cc=self origin/master...master
