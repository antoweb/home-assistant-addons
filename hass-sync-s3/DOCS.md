# How to create a bucket and get an Access key and Secret key

## Idrive e2 1Tb for only about 20/30 $ Year

Create account to https://www.idrive.com/s3-storage-e2/

Go to https://app.idrivee2.com/dashboard

And then create a bucket with :

Bucket name : unique identifier
Region : Ireland for example 

You can choose also object lock, versioning etc...

Npw got to https://app.idrivee2.com/access-key
and create credentials (access key and secret access key)

## Scaleway (70GB free then €0.01/GB/month) --> Best choice

Create an account at : https://console.scaleway.com/register or login if you already have one.

Go to : https://console.scaleway.com/object-storage/buckets

And then create a bucket with :

Bucket name : unique identifier
Region : Paris / Amsterdam / Warsaw
Set bucket visibility : private

Now head to : https://console.scaleway.com/project/credentials
and generate a new API key :
Fill a little description for your memory sake and just copy and paste the access key and secret key in your addon configuration. (Beware, your secret key will only be shown once)

## AWS (No free tiers but and depending on which region, but for example in Frankfurt : $0.0245 per GB)

Create an AWS account or login at :https://console.aws.amazon.com/

Then go to : https://s3.console.aws.amazon.com/s3/ and click create bucket :

Bucket Name : unique bucket name
Region : Region of your choice
Let ticket "Block public access"
Versionning : Disable (if enable, you will not be able to delete older backups without tricky API calls)
Tags : As your will
Default Encryption : You can disable it if you encrypt in client side with GPG (better in term of privacy)

Then head to : https://console.aws.amazon.com/iam/home?#/policies

Click create policy, go on json tab and paste :

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucketMultipartUploads",
                "s3:AbortMultipartUpload",
                "s3:CreateBucket",
                "s3:ListBucket",
                "s3:DeleteObject",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::your-bucket-name",
                "arn:aws:s3:::your-bucket-name/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        }
    ]
}
```

Then create a group at : https://console.aws.amazon.com/iam/home?#/groups with the previously created policy

Then create a user attached to the previously created group. Here you will find the access key and secret key. *Note the name of the created user*

Making these IAM configuration will ensure that if your access key and secret key are stolen, the only ressource it can access is this s3 bucket.

In the addon configuration fill your "accessKey" and "secretKey" and the s3 bucket URL followed by the previously created user name.

Like this : s3://s3.region-name.amazonaws.com/bucket-name/created-user-name

## Backblaze B2 (10GB free then $0.005 /GB/month and $0.01 /GB/download)

Create Backblaze account with B2 enabled

First, you have to create a Backblaze account and enable B2. If you already have a Backblaze account, login, visit "My Settings" and enable "B2 Cloud Storage" on your account under "Enabled Products" 
Second, create an Private bucket in your B2 account.

Third, retrieve your Master Application Key and KeyID. 

Use the keyId and the Master application key to build the bucket url b2://[accessKey]:[secretKey]@[B2 bucket name].

1. Start the add-on.
2. Check the add-on log output to see the result.

If the log doesn't end with an error, the add-on has successfully
accessed your git repository. Examples of logs you might see if
there were no errors are: `[Info] Nothing has changed.`,
`[Info] Something has changed, checking Home-Assistant config...`,
or `[Info] Local configuration has changed. Restart required.`.

If you made it this far, you might want to let the add-on automatically
check for updates by setting the `active` field (a subfield of `repeat`)
to `true` and turning on "Start on boot."



