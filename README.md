# infrastructure-live

This repo sets up cross-account access for IAM users declared in the security
account.  Creating users and assigning them to groups requires root access to
securty account.  If you have access, you will find this in a shared 1password
vault.  But your user should already exist and authentication instructions 
should have been emailed to you.  You have the ability to log in and manage
your own user, but not to set your own permissions.  This means, basically, 
that you can delete and create access keys, update MFA, and reset password.

Nothing else in the system will work until you enable MFA on your user and
authenticate using that MFA.  All policies have conditions which require 
MFA-based login.  Click on your user, then look at security credentials tab, 
and add an MFA.  I like using 1password because it is software I can install on
many devices so I don't always have to have my phone with me.

Once you have mfa enabled for your IAM user, you can create aws profiles which
assume roles in the various accounts.

My .aws/config file looks like this:

```
[profile q-security]
mfa_serial=arn:aws:iam::593971421826:mfa/sgendler

[profile q-root]
source_profile=q-security
role_arn=arn:aws:iam::431823461389:role/cross_account_billing_access
mfa_serial=arn:aws:iam::593971421826:mfa/sgendler

[profile q-dev]
source_profile=q-security
role_arn=arn:aws:iam::507625003920:role/cross_account_full_access
mfa_serial=arn:aws:iam::593971421826:mfa/sgendler

[profile q-stage]
source_profile=q-security
role_arn=arn:aws:iam::178696548878:role/cross_account_full_access
mfa_serial=arn:aws:iam::593971421826:mfa/sgendler

[profile q-prod]
source_profile=q-security
role_arn=arn:aws:iam::062394816843:role/cross_account_read_only_access
mfa_serial=arn:aws:iam::593971421826:mfa/sgendler
```

Note that the mfa_serial is always the mfa from my security iam user, but the
role is the role in the other account.  Permission to assume that role is
assigned to a group you are a member of.

I run terraform by using aws-vault, which knows about my access key for the 
IAM user.

`aws-vault exec q-prod terragrunt apply` (which runs terragrunt against the prod account with your prod role)

You can access the console via:

`aws-vault login q-dev` (which will log in to the dev account with your dev
role)

Note that the root account has no infrastructure, so the role name is
 different - cross_account_billing_access. 

All accounts except root and security have 4 cross-account roles
Security IAM has 4 groups (full_access, dev_access, billing_access,
and read_only_access) for each of dev, stage, and prod accounts, as well as 1
billing group and full access group for root account and 1 self_mgmt group in security.

Administrative users have full access in each environment, as well as self-mgmt.
Regular devs would just have dev_access in environments
(read_only in prod) and self-mgmt.

The dev role grants full access to common aws services for developers instead of
full access to everything. The set of services that devs have access to can be
modified in the _global/iam-roles template in each environment.
