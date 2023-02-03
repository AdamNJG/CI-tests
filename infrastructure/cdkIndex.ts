import * as cdk from 'aws-cdk-lib';
import { CiPipeline } from './pipeline';

const app = new cdk.App();
new CiPipeline(app, 'CiPipeline');