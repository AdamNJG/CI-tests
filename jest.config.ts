export default {
 clearMocks: true,
  preset: 'ts-jest',
  testEnvironment: "node",
  testMatch: [
    "**/tests/*.[jt]s?(x)",
    "**/?(*.)+(spec|test).[tj]s?(x)"
  ],
  transform:{'^.+\\.ts?$': 'ts-jest'}, 
  transformIgnorePatterns: [
     "\\\\node_modules\\\\",
     "\\.pnp\\.[^\\\\]+$"
   ],
};