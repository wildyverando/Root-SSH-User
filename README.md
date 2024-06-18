# Root SSH User
a simple bash script to set sshd user as root

## Manual [ Required to input new password ]
```bash
curl -s "https://raw.githubusercontent.com/wildyverando/Root-SSH-User/main/manual.sh" -o manual.sh
bash manual.sh
```

## Auto [ Automatic generate 12 chars of random password ]
```bash
curl -s "https://raw.githubusercontent.com/wildyverando/Root-SSH-User/main/auto.sh" -o auto.sh
bash auto.sh
```

## Important Note:
- Enabling root SSH access is highly discouraged due to security risks. It's best practice to use a dedicated user account with limited privileges.
