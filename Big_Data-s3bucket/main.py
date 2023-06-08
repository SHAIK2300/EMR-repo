import sys
from datetime import datetime
from pyspark.sql import SparkSession
from  import col

S3_DATA_SOURCE_PATH = 's3://emr-imran-bucket/inputfolder/survey_results_public[1].csv'
S3_DATA_OUTPUT = 's3://emr-imran-bucket/outputfolder'

def main():
    spark = SparkSession.builder.appName('BigDataDemoApp').getOrCreate()
    all_data = spark.read.csv(S3_DATA_SOURCE_PATH, header=True)
    print('Total number of records in dataset: %s' % all_data.count())
    selected_data = all_data.where((col('Country') == 'United States of America') & (col('Age1stCode') == '11 - 17 years'))
    print('Total number of engineers who work more than 45 hours in the US is : %s' % selected_data.count())
    selected_data.write.mode('overwrite').parquet(S3_DATA_OUTPUT)
    print('Selected data was successfully saved to: %s' % S3_DATA_OUTPUT)

if __name__ == '__main__':
    main()




