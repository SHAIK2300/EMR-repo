import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node AWS Glue Data Catalog
AWSGlueDataCatalog_node1679639234914 = glueContext.create_dynamic_frame.from_catalog(
    database="awsglusesampedb",
    table_name="inputfolder",
    transformation_ctx="AWSGlueDataCatalog_node1679639234914",
)

# Script generated for node Amazon S3
AmazonS3_node1679639282854 = glueContext.write_dynamic_frame.from_options(
    frame=AWSGlueDataCatalog_node1679639234914,
    connection_type="s3",
    format="csv",
    connection_options={
        "path": "s3://awsemrbucket-shaik/targetfolder/",
        "partitionKeys": [],
    },
    transformation_ctx="AmazonS3_node1679639282854",
)

job.commit()
