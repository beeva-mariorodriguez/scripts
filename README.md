# beeva-mariorodriguez's scripts

some useful (for me!) scripts

use at your own risk

## aws-vs-ssh.sh

* ``aws-vs-ssh add KEYNAME`` generate a ssh-key and add it to all aws regions as KEYNAME
* ``aws-vs-ssh del KEYNAME`` remove KEYNAME from all aws regions

## touchpad.sh

disable and enable the laptop's touchpad

## auth-aws.sh

authenticate as $AWS_ROLE_ARN to aws using MFA

environment variables needed:
```
AWS_ROLE_ARN
AWS_MFA_ARN
AWS_PROFILE
AWS_SESSION_NAME
```

usage: 
```bash
eval $(./auth-aws.sh $MFA_CODE)
```

