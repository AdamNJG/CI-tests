import * as cdk from 'aws-cdk-lib';
import { CodePipeline, ShellStep } from 'aws-cdk-lib/pipelines';
import { CodePipelineSource } from 'aws-cdk-lib/pipelines';
import { Construct } from 'constructs';


export class CiPipeline extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const branch = 'main';
    const repository = 'AdamNJG/CI-tests';
    const connectionArn = 'arn:aws:codestar-connections:eu-west-2:989261935687:connection/ce16bd64-486c-4048-93e9-41a6882a9ac0';

    const pipeline = new CodePipeline(this,'Pipeline' , {
      pipelineName: 'Pipeline',
      synth: new ShellStep('SynthStep', {
          input: CodePipelineSource.connection(repository, branch, {
              connectionArn: connectionArn
           }),
          installCommands: [
              'npm install'
          ],
          commands: [
              'npm test',
          ]
      })
  })
  }
}
