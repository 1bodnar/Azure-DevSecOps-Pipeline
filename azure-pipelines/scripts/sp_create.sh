# Log in
az login

# Choose correct subscription
az account set --subscription "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"

# Create an app registration + service principal with RBAC
az ad sp create-for-rbac \
  --name "ado-spn-ladislav-test" \
  --role Contributor \
  --scopes /subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
  --sdk-auth

  # Create an app registration + service principal with RBAC
az ad sp create-for-rbac \
  --name "ado-spn-ladislav-test" \
  --role Contributor \
  --scopes /subscriptions/XXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
  --sdk-auth
