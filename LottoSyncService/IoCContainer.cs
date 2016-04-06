using Autofac;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace LottoSyncService
{
    public static class IoCContainer
    {
        public static IContainer BaseContainer { get; private set; }

        public static void Build()
        {
            if (BaseContainer == null)
            {
                var repositoryAssembly = Assembly.Load("Repository.SQL");
                var serviceAssembly = Assembly.Load("Service.Lotto");

                var builder = new ContainerBuilder();

                builder.RegisterAssemblyTypes(repositoryAssembly)
                   .Where(t => t.Name.EndsWith("Repository"))
                   .AsImplementedInterfaces();
                builder.RegisterAssemblyTypes(serviceAssembly)
                       .Where(t => t.Name.EndsWith("Service"))
                        .AsImplementedInterfaces();

                BaseContainer = builder.Build();
            }
        }

        public static TService Resolve<TService>()
        {
            return BaseContainer.Resolve<TService>();
        }
    }
}
