# Project1

**Group Members**:
Roukna Sengupta (UFID - 4947 4474), Anuja Salunkhe (UFID - 3213 0171)

**Size of *work units***: Each worker mines bitcoins of fixed length 32. We split
the string into two parts of length 12 and 20. When a worker requests the server 
for work, the server generates a random string of length 12 and passes it to the 
worker. The worker then recursively mines for bitcoins. On each computation, the 
worker generates the latter part of the string (of length 20) and appends it to the 
string prefix sent by the server and the gator ID. Thus, the worker generates 
the candidate string and further hashes it to check for leading zeroes.
Example:

Server generated prefix (length = 12; sent to worker) - fba4e19ea38be

Worker generated suffix (length = 20) - 8df9c2ff9944c542db5

Candidate string - <gator_id> <> fba4e19ea38be <> 8df9c2ff9944c542db5

By generating the prefix string of length 12 every time a worker requests for 
work, we ensure that no two workers will work on the same string. Generating 
the latter part of the string of length 20 randomly on the nodes induces even 
more randomness in generation of the candidate string, thus, ensuring lesser 
collision in the bitcoins generated by the different workers.

**Result of running program on *./program 4***:
```
roukna-~/Documents/DOS/project1$ ./project1 4
rsengupta;3999fc850726e13a8998c11b07d7ac80	0000edccdbf87b87a5d57f37bd599355e898b579182b0108746a22cc339e6926
rsengupta;69fb694b0099c1ffb8f5b3d9249ce814	00004a4492cf76d1177ae012758325c7f13ddfac24d021ccb2c26e7d30bbad63
rsengupta;69fb694b009968bf2862b59e1a0548d7	0000a4d1e93a93f0a9afcbd1030b07551fcb658a14e20fe763cd23586baa2ba7
rsengupta;850afa05c932f9fe57878150a76be848	000023c4d137373d44d293b478023bf0f8aa67c8849a664c92d407a8c90994a3
rsengupta;850afa05c93247676e1fb0adf1dc782a	00006d3f77f2e75aa7a4f95bd018b34611ee6025033c53f4d7a6cd5075e8f584
rsengupta;850afa05c9324980a539e0a2d68b53cd	0000dedf642259291af62319b0a866b2cd94bf7f69dd70bcc8a977781996b181
rsengupta;3999fc850726f735151caab2bfef9be3	0000553b36307a300ce10ab297a622caf4ad9814f1d9a88251ac2a952544e503
rsengupta;69fb694b0099916bdd2092d3dc5519a0	0000ff7135d0f2013f96ee0e61e7528595600b223a2b72ae9795e1ac471391bb
rsengupta;850afa05c93299180d0c1072484c0f08	00000000b53f5a8ec672c6a73d759866f1229756c018c010cf9f2a55f0786030
rsengupta;69fb694b0099446ba3455975235d015a	0000839ac1b35282dab1d20fc41b752cf08264b2e0c620ff4086efe71a5ac47a
rsengupta;850afa05c932cdab385d7449e108a5d0	000087e2693e935c1e08b1316bd276606717be3e0145af25777f6d854d0a9948
rsengupta;4a4a18ca5b304596ce7a0a0d55b299b2	0000fe8cd0b6044b7a5ddd9234e4f0f1a4f793c8662e6bdddf43697a7f5658e3
rsengupta;4a4a18ca5b30f3b0c9b1ed9764396706	00002d27939296181e4313c3d0697d27daa591e08dc88445cfd244fa4b558d06
rsengupta;4a4a18ca5b30cc5ed2f7971b4530fb99	00002231ae37fbd67956479eccea1fb0d686acc52abe61fc706d1421bc026c31
rsengupta;4a4a18ca5b30c1c40963d6138a5b0100	00001384b08debce29ac82b9fd0f979f0df0dddacd7db4d89884466c0c790130
rsengupta;4a4a18ca5b308b3bb23fb67d2e46e85f	00009bb7f0a628f87765a286bc2e39f9872143f9ac4d7aaae8972698336fcdbf
rsengupta;850afa05c932caa9bfa4ed1545d19c20	0000404937638f253dfcc59ecd01683de30fa5bb37813d10d270a308c82b84de
```

**Result of running program on *./program 5***:
```
roukna-~/Documents/DOS/project1$ time ./project1 5
rsengupta;7082d9f9049f1c29289a7461e62cdd71	000005f46fe43ffb3ddb9ee48a0402afb7e77549592888501bcb79d3fffe3201
rsengupta;7082d9f9049f4496734be7ff2c80ece6	0000088a195c3bc57dfcf04a795670a559fdfdbe21320375d6dac0eacfc69de1
rsengupta;26de5db2dd144ae55385612e1fd2f613	00000747eab10788e79575231eea23a4ce1fa01432f33231ce4f0b1940eb1aac
rsengupta;5cfc9960f924ade0cec61f9c6fbcc8d6	000006cadf002904b2b40f3811a9e901b2d929b972d3c465482be81251b47d26
rsengupta;5cfc9960f9248a5ef68d45ae401f1c6d	00000f9cd2d1e9d8ef289fe128e2230ee1f89441b7751a2dcdbb96276a935552
rsengupta;5cfc9960f924291f7f048fdb743b52f8	00000808f4581ed271c16569f739e1674dee03992f3c95d655e9b143d38aea79
rsengupta;26de5db2dd148eddf61e761e51952b72	000002234e8ba01aef9100e89761e834b7a128fac81962c5e30e3e69dba49544
rsengupta;7082d9f9049f8f8a89bfb3f96bd2c3a9	00000004e9afa2d0bb203adac69f326b7075090ddba8cfcfb08058f49dfc2842
rsengupta;26de5db2dd14274c21f6eb5a9582cc8e	0000005fb9b0bb06a0a3a7a9e86281fe5b537826345f864e64732689774b6f57
rsengupta;fba4e19ea38bc10a3e937ba7d3df8027	00000e2fc35eb125f95c25daf42822ed367521f45c389d83f9e19097b2b3bb8f
rsengupta;26de5db2dd14684330f6331bab11b35b	000002c0de68ab053a2a5e80f2f8fac8b713329b34bd134de7242b202188ceba
rsengupta;7082d9f9049f6ddd0088e748829b671d	0000067a3cfd3d5298e40cf6e76d19b057e770a98b853dffa2684d1883bf5728
rsengupta;26de5db2dd14783e9a34c8884b6b41d1	000003a959f5288a494fbd416da4f833f74d8cd44654054b7ae571460791e666
rsengupta;5cfc9960f9246cc06bb9a5a7f4f7948c	0000060d72d1d7cd979bc536c026d36063f1f8cfac371ea779cad60d29c20efb
rsengupta;fba4e19ea38bf685f71217f05bd5285c	0000013dd6e65caeb89e45463e6724d09bbf9d6f0d9d39610850f215a95632cf
rsengupta;fba4e19ea38bf8fdf34801eb58114717	00000e3a13391243e1984ddfc6cc479a60870fe4c85fac76fde294d2ae406b87
rsengupta;fba4e19ea38be8df9c2ff9944c542db5	00000dfea5fb2b86e9bb24b0a0482addd22ccd92304f34312f33e831f1a0473a

real	0m58.441s
user	3m15.126s
sys	0m18.183s
```
`Ratio of CPU time/Real time: (3m15.126s + 0m18.183s) * 100 /(0m58.441s) = 369.`

**Coin with the most 0s you managed to find**: We were able to mine bitcoins with 7 leading zeroes.
```
Generated escript project with MIX_ENV=dev
roukna-~/Documents/DOS/project1$ ./project1 7
rsengupta;dnmqynej8rqq607d774367e660a1141b	0000000b38f5a0fbcd985722fe8feeb9088b23766009ae221969b50684c53b5c
```

**Largest number of working machines you were able to run your code with**: 4

We were able to run our code on 4 machines, server on one machine and workers on 3 machines.

