#!/bin/bash
PATH="/usr/local/bin:/usr/bin:/bin"

organization_id="ORG ID"
session_key="SESSION KEY"
org_members="$(bw list --session $session_key org-members --organizationid $organization_id | jq -c '.[] | select( .status == 1 )' | jq -c '.id' | tr -d '"')"
for member_id in ${org_members[@]} ; do
        /usr/local/bin/bw confirm --session $session_key org-member $member_id --organizationid $organization_id
done
