# Anatomy of SambaNova PyTorch Models

## Updates

The repo
<https://git.cels.anl.gov/ai-testbed-apps/sambanova/sambanova_starter.git>
has a number of updates to this code including using SLURM via sbatch or
srun which is now the standard.

## Goal

The goal is to have a working model.  This is a SambaNova supplied model
named FFNLogReg.  It has been updated to handle the CLI argument
"measure-performance".

## Code

This code started as an example from SambaNova.
It was then split it into four pieces.
Everything is encapsulated essentially by topic.

1. sn_boilerplate_main.py
    1. Contains the main method.
2. sn_boilerplate_args.py
    1. Contains the arguments.
3. sn_boilerplate_model.py
    1. Contains the model.
4. sn_boilerplate_other.py
    1. Contains the train and test methods and a littile more.

### sn_boilerplate_main.py

```python
"""SambaNova boilerplate main method."""

#import argparse
import sys
#from typing import Tuple


#import torch
#import torch.nn as nn
#import torchvision

from sambaflow import samba

import sambaflow.samba.utils as utils
from sambaflow.samba.utils.argparser import parse_app_args
from sambaflow.samba.utils.pef_utils import get_pefmeta
#from sambaflow.samba.utils.dataset.mnist import dataset_transform
from sambaflow.samba.utils.common import common_app_driver

from sn_boilerplate_args import *
from sn_boilerplate_model import *
from sn_boilerplate_other import *

def consumeVariables(X, Y):
    """Consume variables because SambaNova uses magic."""
    pass

def main(argv):
    """Run main code."""
    utils.set_seed(256)
    args = parse_app_args(argv=argv, common_parser_fn=add_args, run_parser_fn=add_run_args)

    X, Y  = FFNLogReg.get_fake_inputs(args)
    model = FFNLogReg(args.num_features, args.ffn_dim_1, args.ffn_dim_2, args.num_classes)

    # Note: Keep these two lines together and in the same order.  The second line magically uses X and Y behind the scenes.
    consumeVariables(X, Y)
    samba.from_torch_(model)

    inputs = (X, Y)

    # Instantiate an optimizer.
    # Note: --inference can be used with both compile and run commands.
    if args.inference:
        optimizer = None
    else:
        optimizer = samba.optim.SGD(model.parameters(),
                                    lr=args.lr,
                                    momentum=args.momentum,
                                    weight_decay=args.weight_decay)

    name = 'ffn_mnist_torch'

    if args.command == "compile":
        # Run model analysis and compile, this step will produce a PEF.
        samba.session.compile(model,
                              inputs,
                              optimizer,
                              name=name,
                              app_dir=utils.get_file_dir(__file__),
                              config_dict=vars(args),
                              pef_metadata=get_pefmeta(args, model))

    elif args.command == "test":
        samba.utils.trace_graph(model, inputs, optimizer, pef=args.pef, mapping=args.mapping)
        outputs = model.output_tensors
        test(args, model, inputs, outputs)

    elif args.command == "run":
        samba.utils.trace_graph(model, inputs, optimizer, pef=args.pef, mapping=args.mapping)
        train(args, model, optimizer)

    elif args.command == "measure-performance":
        # Contact SambaNova if output gradients are needed to calculate loss on the host.
        common_app_driver(  args=args,
                            model=model,
                            inputs=inputs,
                            name=name,
                            optim=optimizer,
                            squeeze_bs_dim=False,
                            init_output_grads=False,
                            app_dir=utils.get_file_dir(__file__))


if __name__ == '__main__':
    main(sys.argv[1:])
```

Here we have the main method.
We're going to set a seed.

Next set up the arguments.
Parse_app_args(...) will get all of the arguments.
There will be more on this later.

Call FFNLogReg.get_fake_inputs(...).

The SambaNova compiler needs to know the size of
the input of your model and also the
output of your model.
That's what this method is going to provide.

Then go ahead and create a model.
This is a feed forward network with logistical regression.

Call consumeVariables(...).
The SambaNova compiler in the
background is picking up
these variables X and Y
and it is going to use them. 

So you can't just take your X and Y from
here and move them down below.

The next step is very important.
The samba.from_torch_(...) method
is going to take
your model and it's going to do some
conversion on it so that it runs on the
SambaNova machine.

Set up the inputs.

There are four key arguments.

1. --inference
    1. It can be used both with the
compile command and the run command.

    2. When running the code from
the command line you're either going to
compile, test, or run.

    3. With either
compile or run
it's going to be doing inference instead
of training.

    4. If doing inference,
you don't need an optimizer.
Use the optimizer for training.




### sn_boilerplate_args.py

```python
```

### sn_boilerplate_model.py

```python
```

### sn_boilerplate_other.py

```python
```

## References

<https://docs.sambanova.ai/api-reference/index.html>

<https://docs.sambanova.ai/sambanova-docs/1.6/developer/intro-tutorial.html>

<https://docs.sambanova.ai/sambanova-docs/1.6/developer/run-examples-samba.html>

<https://docs.sambanova.ai/sambanova-docs/1.6/developer/compiler-options.html>
