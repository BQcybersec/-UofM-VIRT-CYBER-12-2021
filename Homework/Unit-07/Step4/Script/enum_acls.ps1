$directory = Get-ChildItem 

    foreach ($item in $directory)
        {get-Acl $item |Format-List
        }