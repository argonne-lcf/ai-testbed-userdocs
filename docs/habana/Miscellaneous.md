# Miscellaneous

## Useful Commands

### Card Usage

One may check the card usage status with "hl-smi".

```bash
hl-smi
```

The **hl-smi** will display a report.

The second and third line show the current version.  Here it is **1.6.0**.

Look at the bottom box.
Here it shows that HPU 1 is running your process.
The other HPUs are not running a process of yours.

It will not tell you if someone else is using one or more HPUs.

```text
+-----------------------------------------------------------------------------+
| HL-SMI Version:                    hl-1.6.0-fw-36.3.2.0-1-gda631d8          |
| Driver Version:                                      1.6.0-3c06a7c          |
|-------------------------------+----------------------+----------------------+
| AIP  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | AIP-Util  Compute M. |
|===============================+======================+======================|
|   0  HL-205              N/A  | 0000:19:00.0     N/A |                   0  |
| N/A   35C   N/A   100W / 350W |  32454Mib / 32768Mib |    63%           N/A |
|-------------------------------+----------------------+----------------------+
|   1  HL-205              N/A  | 0000:b3:00.0     N/A |                   0  |
| N/A   28C   N/A    98W / 350W |  32254Mib / 32768Mib |    13%           N/A |
|-------------------------------+----------------------+----------------------+
|   2  HL-205              N/A  | 0000:b4:00.0     N/A |                   0  |
| N/A   20C   N/A   107W / 350W |    512Mib / 32768Mib |    16%           N/A |
|-------------------------------+----------------------+----------------------+
|   3  HL-205              N/A  | 0000:cc:00.0     N/A |                   0  |
| N/A   26C   N/A   107W / 350W |    512Mib / 32768Mib |    16%           N/A |
|-------------------------------+----------------------+----------------------+
|   4  HL-205              N/A  | 0000:cd:00.0     N/A |                   0  |
| N/A   30C   N/A   102W / 350W |    512Mib / 32768Mib |    14%           N/A |
|-------------------------------+----------------------+----------------------+
|   5  HL-205              N/A  | 0000:1a:00.0     N/A |                   0  |
| N/A   25C   N/A   103W / 350W |    512Mib / 32768Mib |    14%           N/A |
|-------------------------------+----------------------+----------------------+
|   6  HL-205              N/A  | 0000:33:00.0     N/A |                   0  |
| N/A   25C   N/A   103W / 350W |    512Mib / 32768Mib |    15%           N/A |
|-------------------------------+----------------------+----------------------+
|   7  HL-205              N/A  | 0000:34:00.0     N/A |                   0  |
| N/A   27C   N/A   102W / 350W |    512Mib / 32768Mib |    14%           N/A |
|-------------------------------+----------------------+----------------------+
| Compute Processes:                                               AIP Memory |
|  AIP       PID   Type   Process name                             Usage      |
|=============================================================================|
|   0        N/A   N/A    N/A                                      N/A        |
|   1       2006754     C   python
                                 31742Mib
|   2        N/A   N/A    N/A                                      N/A        |
|   3        N/A   N/A    N/A                                      N/A        |
|   4        N/A   N/A    N/A                                      N/A        |
|   5        N/A   N/A    N/A                                      N/A        |
|   6        N/A   N/A    N/A                                      N/A        |
|   7        N/A   N/A    N/A                                      N/A        |
+=============================================================================+
```

### How busy is the system?

Use one of

```bash
top
htop
```
