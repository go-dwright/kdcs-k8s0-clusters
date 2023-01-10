

### PRE REQS
replace: {{ your_email }} with your real email
replace: {{ your_public_key }} with your real public key
replace: /path/to/private/key in group_vars/all.yaml with the path to your private key

# building the instances
`aws-vault exec OrganizationEngineerAccessRole -- terraform apply`

# applying ansible 
`aws-vault exec OrganizationEngineerAccessRole  -- ansible-playbook -i kcds.aws_ec2.yaml kcds.yaml`