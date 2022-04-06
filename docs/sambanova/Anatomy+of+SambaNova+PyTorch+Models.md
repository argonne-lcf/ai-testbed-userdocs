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

#### Initial Code

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

#### Inference

The **--inference** argument can be used both with the
compile and run commands.

When running the code from
the command line you're either going to
compile, test, or run.

With either
compile or run
it's going to be doing inference instead
of training.

If doing inference,
you don't need an optimizer.
Use the optimizer for training.

Here sgd is being used as the optimizer.

#### Compile

When you run
with the **--compile** option, the
SambaNova system is going to
compile your model.

The parameters are:

1. model
2. inputs
3. optimizer
4. name
5. app_dir
6. config_dict
7. pef_metadata

#### Test

Checks if the model works.

The ***samba.utils.trace_graph(...)*** method builds the graph that will run on the system.

#### Run

Also calls the samba.utils.trace_graph(...) method to build the graph that will run on the system.

It then calls the **train(...)*** method.

#### Measure Performance

Measures the performance of the model

That's it for main. We are going to
circle around and come back to it.

### sn_boilerplate_args.py

```python
import argparse

def add_args(parser: argparse.ArgumentParser):
    """Add common arguments that are used for every type of run."""
    parser.add_argument('--lr', type=float, default=0.001, help="Learning rate for training")
    parser.add_argument('--momentum', type=float, default=0.0, help="Momentum value for training")
    parser.add_argument('--weight-decay', type=float, default=1e-4, help="Weight decay for training")
    parser.add_argument('-e', '--num-epochs', type=int, default=1)
    parser.add_argument('--num-features', type=int, default=784)
    parser.add_argument('--num-classes', type=int, default=10)
    parser.add_argument('--acc-test', action='store_true', help='Option for accuracy guard test in CH regression.')
    parser.add_argument('--ffn-dim-1', type=int, default=32)
    parser.add_argument('--ffn-dim-2', type=int, default=32)


def add_run_args(parser: argparse.ArgumentParser):
    """Add run arguments."""
    parser.add_argument('--data-folder',
                        type=str,
                        default='mnist_data',
                        help="The folder to download the MNIST dataset to.")
```

Let's look at the args file. This
is pretty straightforward.

Two methods are required:

1. **add_args(...)**

2. **add_run_args(...)**

#### Add_args

The **add_args(...)** method is going to receive a
parser as an argument.

Add common arguments that are used for every type of run.

#### Add_run_args

This method is only for arguments going to be used
when you run the actual model.

It too takes a parser as an argument.

### sn_boilerplate_model.py

```python
"""Boilerplate model definition."""
#import argparse
#import sys
#from typing import Tuple


import torch
import torch.nn as nn
#import torchvision

from sambaflow import samba

#import sambaflow.samba.utils as utils
#from sambaflow.samba.utils.argparser import parse_app_args
#from sambaflow.samba.utils.pef_utils import get_pefmeta
#from sambaflow.samba.utils.dataset.mnist import dataset_transform


class FFN(nn.Module):
    """Feed Forward Network."""

    def __init__(self, num_features: int, ffn_dim_1: int, ffn_dim_2: int) -> None:
        """Initialize the class."""
        super().__init__()
        self.gemm1 = nn.Linear(num_features, ffn_dim_1, bias=False)
        self.relu = nn.ReLU()
        self.gemm2 = nn.Linear(ffn_dim_1, ffn_dim_2, bias=False)

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        """Step forward."""
        out = self.gemm1(x)
        out = self.relu(out)
        out = self.gemm2(out)
        return out


class LogReg(nn.Module):
    """Logreg class."""

    def __init__(self, num_features: int, num_classes: int):
        """Initialize the class."""
        super().__init__()
        self.lin_layer = nn.Linear(in_features=num_features, out_features=num_classes, bias=False)
        self.criterion = nn.CrossEntropyLoss()

    # Note: The forward method can take more than two arguments.
    def forward(self, inputs: torch.Tensor, targets: torch.Tensor) -> torch.Tensor:
        """Step forward."""
        out = self.lin_layer(inputs)
        loss = self.criterion(out, targets)
        return loss, out


class FFNLogReg(nn.Module):
    """Feed Forward Network + LogReg."""

    def __init__(self, num_features: int, ffn_embedding_size: int, embedding_size: int, num_classes: int) -> None:
        """Initialize the class."""
        super().__init__()

        # Note: You can have more than on network in a model.
        self.ffn = FFN(num_features, ffn_embedding_size, embedding_size)
        self.logreg = LogReg(embedding_size, num_classes)
        self._init_params()

    def _init_params(self) -> None:
        for p in self.parameters():
            nn.init.xavier_normal_(p)

    def forward(self, inputs: torch.Tensor, targets: torch.Tensor) -> torch.Tensor:
        """Step forward."""
        out = self.ffn(inputs)
        loss, out = self.logreg(out, targets)

        # Note:  You can return more than one tensor from the forward method.
        return loss, out

    @staticmethod
    def get_fake_inputs(args):
        """
        Get fake inputs.

        The size of the inputs are required for the SambaNova compiler.

        Args:
            args: CLI arguments.

        Outputs:
            X_randn: A Samba tensor representing the correct shape for model inputs.
            Y_randint: A Samba tensor representing the correct shape for model outputs.
        """
        # If the first argument to samba.randn is batch size then the batch_dim is 0.
        X_randn = samba.randn(args.batch_size, args.num_features, name='image', batch_dim=0).bfloat16().float()

        low_inclusive = 0
        high_exclusive = args.num_classes

        # The size/shape of the output tensor.
        size = (args.batch_size, )
        Y_randint = samba.randint(  low_inclusive,
                                    high_exclusive,
                                    size,
                                    name='label',
                                    batch_dim=0)

        return X_randn, Y_randint
```

This model is a feed forward network
with logistical regression.

It's declared within classes which is
highly, highly recommended.

#### FFN

There's an initialization
method.

Here is a
good practice. Go
ahead and create some
variables within the class.
They're
going to be various layers of the model.

It is also possible to use the
**nn.modules(...)** method
and create everything and then skip the
forward section.

If you ever need to do debugging, you're
going to prefer creating layers separately
better.

#### LogReg

There's an initialization method. Declare a few
layers.

Declare your forward method.

These classes basically only have an
initialization method and also a forward method.

#### FFNLogReg

Now combine those two networks.

##### __init__

In the initialization method, you
set up the forward feed network
and you also set up the logistical
regression network.

Next is some parameter initialization.

##### Forward

The **forward(...)** method is very
straightforward.
Call the
feedforward network with the inputs
resulting in
the variable **out**.

Then take **out** and run that
through the logistical regression method
with the targets and to get the loss.

The forward method
combines the feed forward network
with the logistical regression network.

More than one tensor may be returned
in the forward method.

##### GetFakeInputs

Here's a
real important method called **get_fake_inputs(...)**.

That's what they are. They're fake.
They're just random but their size is
very important.

**These must be right.**

The method is set up as a static method
so it isn't necessary to instantiated the class.

For X_randn, call **samba.randn(...)** with these
various arguments, e.g., args.batch_size and args.num_features.

Look at both X_randn and Y_randint.
You'll notice is that the first
dimension of both of those variables is
batch_size.

**Suggestion: Stick to this format.**

Do it like this and always set
**batch_dim** to zero.

This is a classification problem so
next generate some random
integers for **Y_randint**.

Call **samba.randint(...)** here.
**Randint(...)** takes as the first parameter the
lower bound of the random numbers and
this number is inclusive.

Then as the
second parameter it takes the the high
integer that is the desired exclusive.

So if this high number is ten it
excludes that and then you're down to
using nine resulting in 0..9 random integers.
It's
just like the **range(...)** method in Python.

Give it the desired size.

### sn_boilerplate_other.py

```python
import argparse
#import sys
from typing import Tuple


import torch
import torch.nn as nn
import torchvision

from sambaflow import samba

#import sambaflow.samba.utils as utils
#from sambaflow.samba.utils.argparser import parse_app_args
#from sambaflow.samba.utils.pef_utils import get_pefmeta
from sambaflow.samba.utils.dataset.mnist import dataset_transform


def prepare_dataloader(args: argparse.Namespace) -> Tuple[torch.utils.data.DataLoader]:
    """Train the model on RDU using the MNIST dataset (images and labels)."""
    train_dataset = torchvision.datasets.MNIST(root=f'{args.data_folder}',
                                               train=True,
                                               transform=dataset_transform(args),
                                               download=True)
    test_dataset = torchvision.datasets.MNIST(root=f'{args.data_folder}',
                                              train=False,
                                              transform=dataset_transform(args))

    # Data loader (input pipeline)
    train_loader = torch.utils.data.DataLoader(dataset=train_dataset, batch_size=args.batch_size, shuffle=True)
    test_loader = torch.utils.data.DataLoader(dataset=test_dataset, batch_size=args.batch_size, shuffle=False)
    return train_loader, test_loader


def train(args: argparse.Namespace, model: nn.Module, optimizer: samba.optim.SGD) -> None:
    """Train the model."""
    train_loader, test_loader = prepare_dataloader(args)

    total_step = len(train_loader)
    hyperparam_dict = {"lr": args.lr, "momentum": args.momentum, "weight_decay": args.weight_decay}
    for epoch in range(args.num_epochs):
        avg_loss = 0
        for i, (images, labels) in enumerate(train_loader):
            sn_images = samba.from_torch(images, name='image', batch_dim=0)
            sn_labels = samba.from_torch(labels, name='label', batch_dim=0)

            loss, outputs = samba.session.run(input_tensors=[sn_images, sn_labels],
                                              output_tensors=model.output_tensors,
                                              hyperparam_dict=hyperparam_dict)
            loss, outputs = samba.to_torch(loss), samba.to_torch(outputs)
            avg_loss += loss.mean()

            if (i + 1) % 10000 == 0:
                print('Epoch [{}/{}], Step [{}/{}], Loss: {:.4f}'.format(epoch + 1, args.num_epochs, i + 1, total_step,
                                                                         avg_loss / (i + 1)))

        samba.session.to_cpu(model)
        test_acc = 0.0
        with torch.no_grad():
            correct = 0
            total = 0
            total_loss = 0
            for images, labels in test_loader:
                loss, outputs = model(images, labels)
                loss, outputs = samba.to_torch(loss), samba.to_torch(outputs)
                total_loss += loss.mean()
                _, predicted = torch.max(outputs.data, 1)
                total += labels.size(0)
                correct += (predicted == labels).sum()

            test_acc = 100.0 * correct / total
            print('Test Accuracy: {:.2f}'.format(test_acc),
                  ' Loss: {:.4f}'.format(total_loss.item() / (len(test_loader))))

        if args.acc_test:
            assert args.num_epochs == 1, "Accuracy test only supported for 1 epoch"
            assert test_acc > 91.0 and test_acc < 92.0, "Test accuracy not within specified bounds."


def test(args: argparse.Namespace, model: nn.Module, inputs: Tuple[samba.SambaTensor],
         outputs: Tuple[samba.SambaTensor]) -> None:
    """Test the model by compairing the Samba and Torch outputs."""
    samba.session.tracing = False
    outputs_gold = model(*inputs)

    outputs_samba = samba.session.run(input_tensors=inputs,
                                      output_tensors=outputs,
                                      data_parallel=args.data_parallel,
                                      reduce_on_rdu=args.reduce_on_rdu)

    # check that all samba and torch outputs match numerically
    for i, (output_samba, output_gold) in enumerate(zip(outputs_samba, outputs_gold)):
        print('samba:', output_samba)
        print('gold:', output_gold)
        samba.utils.assert_close(output_samba, output_gold, f'forward output #{i}', threshold=3e-3)

    if not args.inference:
        # training mode, check two of the gradients
        torch_loss, torch_gemm_out = outputs_gold
        torch_loss.mean().backward()

        # we choose two gradients from different places to test numerically
        gemm1_grad_gold = model.ffn.gemm1.weight.grad
        gemm1_grad_samba = model.ffn.gemm1.weight.sn_grad

        samba.utils.assert_close(gemm1_grad_gold, gemm1_grad_samba, 'ffn__gemm1__weight__grad', threshold=3e-3)
```

Here is the fourth and final file.

#### Prepare_dataloader

**Prepare_dataloader(...)**
is becoming a standard within the
industry.
It is very handy. It passes out the
information from the data sets on a
batch to batch basis.

That is really
good when you get onto these AI
accelerators.
Actually it's good for even using a
regular computer like your laptop. It
helps to organize your code. And it
makes it very convenient for retrieving
your data.

Grab the **train_dataset** by using
**torchvision.datasets.MNIST** with **train=True**.

Then grab the **test_dataset** by using
**torchvision.datasets.MNIST** with **train=False**.

Now **DataLoader**. This is becoming
an industry standard. Give it the batch_size.
This just really works out for data
pipelining which does get used on the
the bigger systems and AI accelerators.
It also works on your laptop.

Lastly, go ahead and
return both the
**train_loader** and the **train_loader**.

#### Train

next here we're going to get into the
12:29
train method which is used to train the
12:32
model
12:33
so if you look over here here is our
12:35
friend repair data loader so this really
12:38
really helps out you got a single line
12:41
within your train method for actually
12:44
creating both the train loader and also
12:46
the test loader
12:48
so we grab the total number of steps
12:51
we're going to establish a hyper
12:53
parameter dictionary and what we're
12:56
going to do is we're going to put in
12:58
these various arguments here
13:00
one of the main uses of the hyper
13:02
parameter dictionary is to allow
13:04
arguments to be updated during runtime
13:07
ensemble flow for example the step
13:10
learning rate
13:11
and here's pretty much a standard loop
13:14
for stepping through your epochs we're
13:16
going to enumerate through the train
13:18
lever we do have to
13:20
do this step here so we have to do this
13:24
samba. from torch
13:26
and then we're passing in the images in
13:29
the name and then that's going to
13:31
convert those tensors from torch tensors
13:34
to samba tensors so we're also going to


## References

<https://docs.sambanova.ai/api-reference/index.html>

<https://docs.sambanova.ai/sambanova-docs/1.6/developer/intro-tutorial.html>

<https://docs.sambanova.ai/sambanova-docs/1.6/developer/run-examples-samba.html>

<https://docs.sambanova.ai/sambanova-docs/1.6/developer/compiler-options.html>
